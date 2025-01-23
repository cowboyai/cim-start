use crate::modules::{
    article::Article, aside::Aside, header::Header, history::History, nav::Nav, textinput::TextIn,
};
use leptos::prelude::*;

#[component]
pub fn HomePage() -> impl IntoView {
    view! {
          <Header/>
          <div id="main">
            <Article>
                <History>
                    <p>"something"</p>
                </History>
                <TextIn/>
            </Article>
            <Nav/>
            <Aside>
                <li>
                    <a href="#">
                        <i class="fa-solid fa-hexagon-nodes-bolt"></i>
                        "Model"
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="fa-solid fa-bullseye"></i>
                        "Goals"
                    </a>
                </li>
            </Aside>
          </div>
          <footer>"Copyright (c) 2025 - Cowboy AI"</footer>
    }
}
