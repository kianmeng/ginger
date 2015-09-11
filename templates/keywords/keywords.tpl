{% with id.o.subject as results %}
    {% if results|length > 0 %}

            <div class="keywords">

                <p class="keywords__label">{_ Op basis van deze trefwoorden _}</p>

                <ul class="keywords__list">
                    {% for id in results %}
                        <li><a href="/all_in/?id={{id.id}}&type=subject&direction=object">{{ m.rsc[id].title }}</a></li>
                    {% endfor %}
                </ul>

            </div>

    {% endif %}
{% endwith %}
