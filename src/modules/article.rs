use leptos::prelude::*;

#[component]
pub fn Article(children: Children) -> impl IntoView {
    view! {
        <article>
            {children()}
        </article>
    }
}
