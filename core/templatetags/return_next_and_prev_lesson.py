from django import template

register = template.Library()


@register.filter
def return_next_slug(l, i):
    try:
        lesson = l[i + 1]
        return lesson.slug
    except:
        return None


@register.filter
def return_next_name(l, i):
    try:
        lesson = l[i + 1]
        return lesson.name
    except:
        return None


@register.filter
def return_prev_slug(l, i):
    try:
        lesson = l[i - 1]
        return lesson.slug
    except:
        return None


@register.filter
def return_prev_name(l, i):
    try:
        lesson = l[i - 1]
        return lesson.name
    except:
        return None
