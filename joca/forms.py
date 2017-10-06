from accounts.forms import SignupForm

from .models import JocaUser

class JocaSignupForm(SignupForm):

    def clean_username(self):
        return self.data['email']

    def save(self, request):
        user = super(JocaSignupForm, self).save(request)
        user.save()

        jocaUser = JocaUser.objects.create(user=user)
        jocaUser.save()

        return user
