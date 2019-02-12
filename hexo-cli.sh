# Use this script to handle blog
#

if [ $# -eq 0 ]
then
        echo "Missing options!"
        echo "(run $0 -h for help)"
        echo ""
        exit 0
fi

ECHO="false"

COMMENT=$2

while getopts "he" OPTION; do
        case $OPTION in

                e)
                        ECHO="true"
                        ;;
                d)
                        hexo clean;
                        hexo g;
                        hexo d;
                        ;;
                s)
                        hexo clean;
                        hexo s;
                        ;;
                gtam)
                        git add .;
                        git commit -m "$COMMENT";
                        git push;
                        ;;
                h)
                        echo "Usage:"
                        echo "args.sh -h "
                        echo "args.sh -e "
                        echo ""
                        echo "   -e     to execute echo \"hello world\""
                        echo "   -h     help (this output)"
                        exit 0
                        ;;

        esac
done

if [ $ECHO = "true" ]
then
        echo "Just for fun.";
fi