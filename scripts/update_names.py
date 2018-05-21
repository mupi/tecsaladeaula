from accounts.models import TimtecUser
import re

cont = 0
for user in TimtecUser.objects.all():
    complete_name = user.first_name + " " + user.last_name
    complete_name = re.sub(' +',' ', complete_name)

    if (complete_name != ' '):
        user.first_name = complete_name
        user.last_name = ''
        user.save()
        cont = cont + 1
print(str(cont) + " Nomes atualizados")