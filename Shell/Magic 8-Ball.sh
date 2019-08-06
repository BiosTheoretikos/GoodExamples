#!/bin/sh

# magic 8 ball. Yup. Pick a random number, output message

# messages harvested from the Wikipedia entry

answers=("It is certain." "It is decidedly so."
  "Without a doubt." "Yes - definitely."
  "You may rely on it." "As I see it, yes." "Most likely."
  "Outlook good." "Yes." "Signs point to yes."
  "Reply hazy, try again." "Ask again later."
  "Better not tell you now." "Cannot predict now."
  "Concentrate and ask again." "Don't count on it."
  "My reply is no." "My sources say no."
  "Outlook not so good." "Very doubtful.")

echo "Oh! Magic 8 Ball, Please Tell Me True..." ; echo ""
/bin/echo -n "What is your question? "
read question

answer=$(( $RANDOM % 20 ))

echo ""
echo "I have looked into the future and I say: "
echo "     ${answers[$answer]}" ; echo ""

exit 0