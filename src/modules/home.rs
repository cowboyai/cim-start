use crate::modules::{
    article::Article,
    aside::{Aside, AsideItem},
    header::Header,
    history::History,
    nav::{Nav, NavItem},
    textinput::TextIn,
};
use leptos::prelude::*;

#[component]
pub fn HomePage() -> impl IntoView {
    let copyright = "Copyright ©2025 - Cowboy AI";
    let nav_title = "Services";
    view! {
          <Header/>
          <div id="main">
            <Article>
                <History>
                    {view!{}}
                </History>
                <TextIn/>
            </Article>
            <Nav title={String::from(nav_title)}>
                <NavItem link="#".to_string() icon="fa-dashboard".to_string() label="Dashboard".to_string() />
                <NavItem link="#".to_string() icon="fa-arrows-to-circle".to_string() label="Domain".to_string() />
                <NavItem link="#".to_string() icon="fa-diagram-project".to_string() label="Workflow".to_string() />
                <NavItem link="#".to_string() icon="fa-comment".to_string() label="Comms".to_string() />
                <NavItem link="#".to_string() icon="fa-brain".to_string() label="AI".to_string() />
                <NavItem link="#".to_string() icon="fa-clipboard".to_string() label="Notes".to_string() />
                <NavItem link="#".to_string() icon="fa-file-waveform".to_string() label="Docs".to_string() />
                <NavItem link="#".to_string() icon="fa-gear".to_string() label="Settings".to_string() />
            </Nav>
            <Aside>
                <AsideItem link="#".to_string() icon="fa-hexagon-nodes".to_string() label="Model".to_string()/>
                <AsideItem link="#".to_string() icon="fa-bullseye".to_string() label="Goals".to_string()/>
            </Aside>
          </div>
          <footer>{copyright}</footer>
    }
}
