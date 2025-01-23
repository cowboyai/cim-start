use leptos::prelude::*;

#[component]
pub fn Nav(title: String, children: Children) -> impl IntoView {
    view! {
        <nav>
            <div class="nav title"><h2>{title}</h2></div>
            <ul>
                {children()}
            </ul>
        </nav>
    }
}

#[component]
pub fn NavItem(label: String, icon: String, link: String) -> impl IntoView {
    view! {
        <li>
            <a href=link>
                <i class=["fa-solid", icon.as_str()].join(" ")/>
                {label}
            </a>
        </li>
    }
}
