## chop_TextGrid_by_alignment.Praat
##
## This Praat script takes a TextGrid file with several labelled sections and extracts
## every labelled segment into its own TextGrid file (with all labels on the other tiers).
##
## George Moroz - 2017
## National Research University Higher School of Economics
## Faculty of Humanities / School of Linguistics
##
## based on chop_for_alignment.Praat by Eric Doty - 2011
## http://www.ling.upenn.edu/courses/Fall_2013/ling520/chop_soundfile.Praat
## University of Pennsylvania - Linguistics Department
##

form Make text file from an IntervalTier in the selected TextGrid object
	comment Directory of TextGrids and wav files: (Note: Include final slash in directories)
	comment e.g. Mac or Linux: /User/docs/filedirectory/	PC: C:\Users\user\filedirectory\
	text path_in /home/agricolamz/_DATA/OneDrive1/_Work/_Students/2016_Sigova_Adyghe/D1/
	comment Tier number used for chopping
	integer Tier_num 2
	comment Directory to save chopped up sound files:
	text path_out /home/agricolamz/_DATA/OneDrive1/_Work/_Students/2016_Sigova_Adyghe/D1/
endform

overwrite = 0

# text grids
 	Create Strings as file list... filelist 'path_in$'*.TextGrid

# select each file from the textgrid string to work on one at a time
	number_of_files = Get number of strings

 	for t from 1 to number_of_files
		select Strings filelist
		current_file$ = Get string... t

# open the text grid and wav files
		Read from file... 'path_in$''current_file$'
		object_name$ = selected$ ("TextGrid")

# for counting the number of extracted intervals		
		int = 0

# find the relevant intervals
		select TextGrid 'object_name$'
		number_of_intervals = Get number of intervals... tier_num

		for y from 1 to number_of_intervals
# find the label
			select TextGrid 'object_name$'
			interval_label$ = Get label of interval... tier_num y

# if the interval is labeled (not null)
			if interval_label$ <>"" and interval_label$ <>" " and interval_label$ <>"  " and interval_label$ <> "xxx"

# count it
				int = int+1

# find the start and end
				begin = Get starting point... tier_num y
				end = Get end point... tier_num y

# make the new TextGrid
				
					select TextGrid 'object_name$'
					
					Edit
					editor TextGrid 'object_name$'
					Select... begin end
					Extract selected TextGrid (time from zero)
					Close

					select TextGrid 'object_name$'
					Write to text file... 'path_out$''interval_label$'.TextGrid
					Remove
			endif
		endfor
		
# clean up
		select TextGrid 'object_name$'
		Remove

	endfor
select Strings filelist
Remove

