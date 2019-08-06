# PLAYING CARD LIBRARY OF FUNCTIONS
#     not separately executable
#     initialize, then shuffle, then start playing!

function initializeDeck
{
    # Start by creating the deck of cards

    card=1
    while [ $card -le 52 ]	 # 52 cards in a deck. But you knew that, right?
    do
      deck[$card]=$card
      card=$(( $card + 1 ))
    done
}

function shuffleDeck
{
    # Well, it's not really a shuffle, it's a random extraction of card values
    # from the 'deck' array, creating newdeck[] as the "shuffled" deck

    count=1

    while [ $count -le 52 ]
    do
      pickCard
      newdeck[$count]=$picked
      count=$(( $count + 1 ))
    done
}

function pickCard
{
    # This is the most interesting function: pick a card from the deck randomly
    #   Uses the deck[] array to find an available card slot.

    local errcount randomcard

    threshold=10		# max guesses for a card before we fall through
    errcount=0

    # we randomly try to pick a card that hasn't already been pulled from the deck
    # a max of $threshold times (no bad randomizer infinite loop, please)

    while [ $errcount -lt $threshold ]
    do
      randomcard=$(( ( $RANDOM % 52 ) + 1 ))
      errcount=$(( $errcount + 1 ))

      if [ ${deck[$randomcard]} -ne 0 ] ; then
	picked=${deck[$randomcard]}
	deck[$picked]=0		# picked, remove it
        return $picked 
      fi
    done

    # If we get here, we've been uanble to randomly pick a card so we'll just 
    # step through the array until we find an available card

    randomcard=1

    while [ ${newdeck[$randomcard]} -eq 0 ]
    do
       randomcard=$(( $randomcard + 1 ))
    done

    picked=$randomcard
    deck[$picked]=0		# picked, remove it

    return $picked
}

function showCard
{
   # This uses a div and a mod to figure out suit and rank, tho
   # in this game only rank matters. Still, presentation is
   # important too, so this helps make things pretty.

   card=$1

   if [ $card -lt 1 -o $card -gt 52 ] ; then
     echo "Bad card value: $card"
     exit 1
   fi

   # div and mod. See, all that math in school wasn't wasted!

   suit="$(( ( ( $card - 1) / 13 ) + 1))"
   rank="$(( $card % 13))"

   case $suit in
     1 ) suit="Hearts"	  ;;
     2 ) suit="Clubs"    ;;
     3 ) suit="Spades"   ;;
     4 ) suit="Diamonds" ;;
     * ) echo "Bad suit value: $suit"; exit 1
   esac 
    
   case $rank in 
     0 ) rank="King" 	;;
     1 ) rank="Ace"	;;
     11) rank="Jack"    ;;
     12) rank="Queen"   ;;
   esac

   cardname="$rank of $suit"
}

# USAGE: 
#
#  initializeDeck
#  shuffleDeck
#
#  deal cards
#
#  play loop

