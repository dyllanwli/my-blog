<template>
  <transition appear name="v--mask">
    <footer v-once class="blog__footer">
      <a class="signature" href="https://vuejs.org" target="_blank">
        <!-- <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Vue.js_Logo.svg/32px-Vue.js_Logo.svg"/> -->
      </a>
    </footer>
  </transition>
</template>

<script>
export default { name: 'blog-footer' }
</script>
