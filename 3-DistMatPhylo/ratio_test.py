import sys

# Customize function for ratio tests
def ratio_test(src, dist, ratio=0.6):
    """
    Ratio Test Function
    filtering the generated fasta file and trim
    the fasta sequence that does not meet the given
    ratio.
    This algorithm reads over each individual line and
    conduct the ratio test to cehck it's validity. Once
    a line failed the ratio test, the previous line will 
    also be omitted because it will be the header of the 
    fasta sequence.
    :param src: the source directory for fasta file
    :param dist: the target directory for output fasta
    :param ratio: the ratio that each sequence need to pass
    :return: describe what it returns
    """
    # The buffer that hosts a list of line in iniput file
    data = []
    # Open the input fasta and reaad it with utf-8 encoding
    with open(src, "r", encoding="utf-8") as fasta:
        # Load a single line of data into the string buffer
        buffer = fasta.readline()
        # Loop untill the EOF is reached
        while buffer:
            # Counduct ratio test for each line, reagardless it's a fasta
            # sequence or header. If the number of the ratio of the
            # gap (denoted as "-") is more than meaningful for characters
            # in a sequence.
            if buffer.count("-") > len(buffer) * ratio:
                # Print the sequence that does not meet the requirements
                print(buffer)
                # Pop the previous line from the data so the header
                # of the fasta will be dropped out
                data.pop()
            else:
                # If the sequence passed the ratio test, it will be added
                # into the data buffer
                data.append(buffer)
            # Read the next line of the file
            buffer = fasta.readline()
    # Open the target directory with write mode and save the file in utf-8 format
    with open(dist, "w", encoding="utf-8") as fasta:
        # Write all data into the dist file in multiple lines
        fasta.writelines(data)

ratio_test(sys.argv[1], sys.argv[2])
