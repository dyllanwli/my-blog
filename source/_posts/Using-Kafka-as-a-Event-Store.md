---
layout: title
title: Using Kafka as a Event Store
date: 2019-02-10 16:11:12
tags: Distributed System
categories: Tech
---
Kafka is meant to be a messaging system which has many similarities to an event store however to quote their intro:

> The Kafka cluster retains all published messages—whether or not they
> have been consumed—**for a configurable period of time**. For example if
> the retention is set for two days, then for the two days after a
> message is published it is available for consumption, after which it
> will be discarded to free up space. Kafka's performance is effectively
> constant with respect to data size so retaining lots of data is not a
> problem.

So while messages can potentially be retained indefinitely, the expectation is that they will be deleted. This doesn't mean you can't use this as an event store, but it may be better to use something else. Take a look at [EventStore][1] for an alternative.

[Kafka documentation](http://kafka.apache.org/documentation.html):

> Event sourcing is a style of application design where state changes are logged as a time-ordered sequence of records. Kafka's support for very large stored log data makes it an excellent backend for an application built in this style.

One concern with using Kafka for event sourcing is the number of required topics. Typically in event sourcing, there is a stream (topic) of events per entity (such as user, product, etc). This way, the current state of an entity can be reconstituted by re-applying all events in the stream. Each Kafka topic consists of one or more partitions and each partition is stored as a directory on the file system. There will also be pressure from ZooKeeper as the number of znodes increases.

Other things that we should notice are:

 - Kafka only guarantees at least once deliver and there are duplicates
   in the event store that cannot be removed. 
   Here you can read why it is so hard with Kafka and some latest news about how to finally achieve this behavior: https://www.confluent.io/blog/exactly-once-semantics-are-possible-heres-how-apache-kafka-does-it/
 - Due to immutability, there is no way to manipulate event store when application evolves and events need to be transformed (there are of course methods like upcasting, but...). Once might say you never need to transform events, but that is not correct assumption, there could be situation where you do backup of original, but you upgrade them to latest versions. That is valid requirement in event driven architectures.
 - No place to persist snapshots of entities/aggregates and replay will become slower and slower. Creating snapshots is must feature for event store from long term perspective. 
 - Given Kafka partitions are distributed and they are hard to manage and
   backup compare with databases. Databases are simply simpler

So, before you make your choice you think twice. Event store as combination of application layer interfaces (monitoring and management), SQL/NoSQL store and Kafka as broker is better choice than leaving Kafka handle both roles to create complete feature full solution.

Event store is complex service which requires more than what Kafka can offer if you are serious about applying Event sourcing, CQRS, Sagas and other patterns in event driven architecture and stay high performance.

Please look at eventuate.io microservices open source framework to discover more about the potential problems: http://eventuate.io/

### Back to Topic
- Using Kafka as a event soursing? Yes or No, depending on your event sourcing usage.
- It can be used in downstream event processors
In this kind of system, events happen in the real world and are recorded as facts. Such as a warehouse system to keep track of pallets of products. There are basically no conflicting events. Everything has already happened, even if it was wrong. (I.e. pallet 123456 put on truck A, but was scheduled for truck B.) Then later the facts are checked for exceptions via reporting mechanisms. Kafka seems well-suited for this kind of down-stream, event processing application.

In this context, it is understandable why Kafka folks are advocating it as an Event Sourcing solution. Because it is quite similar to how it is already used in, for example, click streams. However, people using the term Event Sourcing (as opposed to Stream Processing) are likely referring to the second usage...
- It CANNOT be used in Application-controlled source of truth

This kind of application declares its own events as a result of user requests passing through business logic. Kafka does not work well in this case for two primary reasons.
+ Lack of entity isolation

This scenario needs the ability to load the event stream for a specific entity. The common reason for this is to build a transient write model for the business logic to use to process the request. Doing this is impractical in Kafka. Using topic-per-entity could allow this, except this is a non-starter when there may be thousands or millions of that entity. This is due to technical limits in Kafka/Zookeeper. Using topic-per-type is recommended instead for Kafka, but this would require loading events for every entity of that type just to get events for a single entity. Since you cannot tell by log position which events belong to which entity. Even using Snapshots to start from a known log position, this could be a significant number of events to churn through. But snapshots cannot help you with code changes. Because adding new features to the business logic may render previous snapshots structurally incompatible. So it is still necessary to do a topic replay in those cases to build a new model. One of the main reasons to use a transient write model instead of a persisted one is to make business logic changes cheap and easy to deploy.

+ Lack of conflict detection

Secondly, users can create race conditions due to concurrent requests against the same entity. It may be quite undesirable to save conflicting events and resolve them after the fact. So it is important to be able to prevent conflicting events. To scale request load, it is common to use stateless services while preventing write conflicts using conditional writes (only write if the last entity event was #x). A.k.a. Optimistic Concurrency. Kafka does not support optimistic concurrency. Even if it supported it at the topic level, it would need to be all the way down to the entity level to be effective. To use Kafka and prevent conflicting events, you would need to use a stateful, serialized writer at the application level. This is a significant architectural requirement/restriction.

  [1]: http://geteventstore.com/