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
