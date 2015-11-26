
{% with
    limit|default:9999,
    id.s.participant
as
    limit,
    participant
%}
{% if participant %}
    <div id="participants" class="meta-participants">
        <h4 class="meta-participants__header"><i class="icon--person"></i>{_ Participants _}</h4>
            <div class="meta-participants__content">
                {% for p in participant|slice:[,limit] %}
                    <a href="{{ p.page_url }}">{{ p.title }}</a>{% if not forloop.last %}, {% endif %}
                {% endfor %}
            </div>
    </div>
{% endif %}
{% endwith %}
