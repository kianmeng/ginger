<nav class="main-nav do_ginger_default_toggle_navigation do_ginger_default_toggle_search">
    <a href="/" class="main-nav__logo">
        {% block mainNavLogo %}
            <img src="/lib/images/logo_ginger.png"/>
        {% endblock %}
    </a>

    <div class="main-nav__off-canvas">
        {% menu class="main-nav__pages" %}

        {% block mainNavActions %}
            <ul class="main-nav__actions">
                <li>
                    {% optional include "_nav_logon.tpl" %}
                </li>
                <li>
                    {% optional include "_nav_admin.tpl" %}
                </li>
            </ul>
        {% endblock %}
    </div>

    <ul class="main-nav__actions">
        <li class="main-nav__toggle-search"><a href="#main-nav__search-form">{_ Zoek _}</a></li>
        <li class="main-nav__toggle-menu"><a href="#navigation">{_ Toggle menu _}</a></li>
    </ul>

    <div class="main-nav__search">
        {% include "_search_form.tpl" identifier="main-nav" %}
        <button class="main-nav__search__close-btn" type="button">{_ Sluiten _}</button>
    </div>
</nav>