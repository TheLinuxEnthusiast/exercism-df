

def grep(pattern, flags, files):
    import re
    """
    Description: Function that implements grep functionality for pattern matching text from a text file
    Args:
        - pattern: Pattern of text to search for within input file
        - flags: 1 - Many flag argument options
        - files: List of files to parse
    """
    
    flags_lst = flags.split(" ")
    
    result = []

    file_count = len(files)

    for f in files:
        line_count = 1

        with open(f"{f}", "r+") as fd:
            lines = fd.readlines()
            for line in lines:

                if "-i" in flags_lst:
                    #print("Case insensitive")
                    if "-x" in flags_lst:
                        #print("Whole match")
                        match = re.findall(fr'^{pattern.lower()}$', line.lower())
                    else:
                        match = re.findall(fr'{pattern.lower()}', line.lower())
                else:
                    if "-x" in flags_lst:
                        #print("Whole match case sensitive")
                        match = re.findall(fr'^{pattern}$', line)
                    else:
                        match = re.findall(fr'{pattern}', line)



                if "-l" in flags_lst:
                    #print("File Names only")
                    if match:
                        result.append(f)
                else:

                    if "-v" in flags_lst:
                        #print("Add non matches to result")
                        if "-n" in flags_lst:
                            if file_count > 1 and not match:
                                result.append(f"{f}:{line_count}:{line}")
                            elif not match:
                                #print("Add line number to each line matched")
                                result.append(f"{line_count}:{line}")
                        else:
                            #print("No line number and inverted")
                            if file_count > 1 and not match:
                                result.append(f"{f}:{line}")
                            elif not match:
                                #print("No line number and inverted")
                                result.append(f"{line}")

                    else:
                        #print("add match to result")
                        if "-n" in flags_lst:
                            #print("Add line number to each line matched")
                            if file_count > 1 and match:
                                result.append(f"{f}:{line_count}:{line}")
                            elif match:
                                #print("Add line number to each line matched")
                                result.append(f"{line_count}:{line}")
                        else:
                            #print("No line number")
                            if file_count > 1 and match:
                                result.append(f"{f}:{line}")
                            elif match:
                                #print("No line number with match")
                                result.append(f"{line}")


                line_count+=1
    

    def f_return(seq): # Order preserving
        seen = set()
        return [x+"\n" for x in seq if x not in seen and not seen.add(x)]


    if "-l" in flags_lst:
        return "".join(f_return(result))
    else:
        return "".join(result)

if __name__ == "__main__":
    print(grep("TO", "-i", ["iliad.txt", "midsummer-night.txt", "paradise-lost.txt"]))

            


