BOOKS=alice christmas_carol dracula frankenstein heart_of_darkness life_of_bee moby_dick modest_propsal pride_and_prejudice tale_of_two_cities ulysses

FREQLISTS=$(BOOKS:%=results/%.freq.txt)
SENTEDBOOKS=$(BOOKS:%=results/%.sent.txt)
#BIGFILE=$(BOOKs:%= >>)

all: $(FREQLISTS) $(SENTEDBOOKS)

clean:
	rm -f results/* data/*no_md.txt

#data/all.no_md.txt: data/alice.txt data/christmas_carol.txt
#	python3 src/remove_gutenberg_metadata.py  $^ $@
# – not sure what to do and where:
# python3 src ... | cat $^ >> $@
# cat $^ >> $@ | python3 src....
# BIGFILE=$(BOOKS:%= >> ?? ))


%.no_md.txt: %.txt
	python3 src/remove_gutenberg_metadata.py $< $@

results/%.freq.txt: data/%.no_md.txt 
	src/freqlist.sh $< $@

results/%.sent.txt: data/%.no_md.txt
	src/sent_per_line.sh $< $@
