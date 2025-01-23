use leptos::prelude::*;

#[component]
pub fn Aside(children: Children) -> impl IntoView {
    view! {
        <aside>
            <ul>
                {children()}
            </ul>
        </aside>
    }
}

#[component]
pub fn AsideItem(link: String, icon: String, label: String) -> impl IntoView {
    view! {
        <li>
            <a href=link>
                <i class=["fa-solid", icon.as_str()].join(" ")/>
                {label}
            </a>
        </li>
    }
}
