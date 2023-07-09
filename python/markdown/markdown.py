import re


def parse(markdown):
    lines = markdown.split('\n')

    res = ''

    in_list = False

    in_list_append = False

    for i in lines:
        # checking for heading style
        m = re.match('^(#{1,6}) (.*)', i)
        if m:
            header_length = len(m.group(1))
            i = f'<h{header_length}>' + i[header_length+1:] + f'</h{header_length}>'

        # Checking for bullet point
        m = re.match(r'\* (.*)', i)

        if m:
            curr = m.group(1)
            m1 = re.match('(.*)__(.*)__(.*)', curr)
                    
            if m1:
                curr = m1.group(1) + '<strong>' + \
                    m1.group(2) + '</strong>' + m1.group(3)
                
            m1 = re.match('(.*)_(.*)_(.*)', curr)
            if m1:
                curr = m1.group(1) + '<em>' + m1.group(2) + \
                    '</em>' + m1.group(3)
                    
            if not in_list:
                in_list=True
                i = '<ul><li>' + curr + '</li>'
            else:
                i = '<li>' + curr + '</li>'
                
        else:
            if in_list:
                in_list_append = True
                in_list = False

        m = re.match('<h|<ul|<p|<li', i)
        if not m:
            i = '<p>' + i + '</p>'
        m = re.match('(.*)__(.*)__(.*)', i)
        if m:
            i = m.group(1) + '<strong>' + m.group(2) + '</strong>' + m.group(3)
        m = re.match('(.*)_(.*)_(.*)', i)
        if m:
            i = m.group(1) + '<em>' + m.group(2) + '</em>' + m.group(3)
        if in_list_append:
            i = '</ul>' + i
            in_list_append = False
        res += i
    if in_list:
        res += '</ul>'
    return res


if __name__ == "__main__":
    print(parse("# Header!\n* __Bold Item__\n* _Italic Item_"))
    # <h1>Header!</h1><ul><li><strong>Bold Item</strong></li><li><em>Italic Item</em></li></ul>