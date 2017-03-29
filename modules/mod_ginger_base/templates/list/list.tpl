{% with
    items,
    cols,
    extraClasses,
    class|default:"list",
    list_id|default:"",
    hide_showmore_button,
    showmore_button_text|default:_"Show more results...",
    list_items_template|default:"list/list-items.tpl",
    list_template|default:"list/list-item.tpl",
    noresults,
    show_pager
as
    items,
    cols,
    extraClasses,
    class,
    list_id,
    hide_showmore_button,
    showmore_button_text,
    list_items_template,
    list_template,
    noresults,
    show_pager
%}

    {% if items %}

      {% if show_pager %}
          {% include "pager/pager.tpl" %}
      {% endif %}

        <ul id="{{ list_id }}" class="{{ class }} {{ extraClasses }}">
            {% include list_items_template items=items list_item_template=list_template %}
        </ul>

        {% if not hide_showmore_button %}

            <div id="{{ list_id }}-buttons">

                {% if not hide_showmore_button %}
                    {% button class="list__more" text=showmore_button_text action={moreresults result=result
                        target=list_id
                        template=list_template
                        catinclude }
                        %}
                {% endif %}

            </div>

        {% endif %}

        {% if show_pager %}
            {% include "pager/pager.tpl" %}
        {% endif %}

    {% else %}
        {% if noresults %}
            <p class="no-results">{_ No results _}</p>
        {% endif %}
    {% endif %}



{% endwith %}
