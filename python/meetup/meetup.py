from calendar import Calendar
from datetime import date
import calendar

# subclassing the built-in ValueError to create MeetupDayException
class MeetupDayException(ValueError):
    """Exception raised when the Meetup weekday and count do not result in a valid date.

    message: explanation of the error.

    """
    def __init__(self, message):
        self.message = message


def meetup(year, month, week, day_of_week):
    """
    Description: Function for returning the first, second,, third, forth, last & teenth day
    of the month. 
    """
    
    descriptor_map = {
        "first": 0,
        "second": 1,
        "third": 2,
        "fourth": 3,
        "fifth": 4,
        "last": -1,
        "teenth": None
    }

    _days = {
        "Monday": 0,
        "Tuesday": 1,
        "Wednesday": 2,
        "Thursday": 3,
        "Friday": 4,
        "Saturday": 5,
        "Sunday": 6
    }

    if week not in list(descriptor_map.keys()):
        raise MeetupDayException("That day does not exist.")

    cal = Calendar()

    w = [d for d in cal.monthdays2calendar(year, month)]
    print(w)
    list_of_days = [day for _week in w for day in _week if day[0]>0 and day[1] == _days[day_of_week]]
    print(list_of_days)

    if week == "teenth":
        for i in list_of_days:
            if i[0]>12 and i[0] <= 19:
                #print(i[1])
                return date(year, month, i[0])
    else:
        try:
            val = list_of_days[descriptor_map[week]]
        except Exception as e:
            raise MeetupDayException("That day does not exist.")
        
    return date(year, month, val[0])