import styled from "styled-components";

export const PageLayout = styled.div`
  width: 100vw;
  height: 100vh;
  display: flex;
  overflow: hidden;

  * {
    box-sizing: border-box;
  }
`;

export const Sidebar = styled.div`
  width: 300px;
  padding: 20px;
  background-color: #121212;
  color: white;
  overflow-y: auto;
  font-family: "Roboto", sans-serif;
`;

export const MapWrapper = styled.div`
  flex: 1;
  height: 100%;
  background-color: #1e1e1e;
  position: relative;

  .leaflet-container {
    width: 100%;
    height: 100%;
    z-index: 0;
  }
`;

export const Panel = styled.div`
  position: absolute;
  top: 16px;
  right: 16px;
  z-index: 1000;
  background: white;
  padding: 16px;
  border-radius: 8px;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.15);
  width: 150px;
  height: 380px;
  ul {
    padding: 0;
    list-style: none;
  }
  font-size: 20px;
  font-family: "Roboto", sans-serif;
  h1 {
    font-size: 20px;
    margin-bottom: 16px;
  }
`;

export const List = styled.ul`
  list-style: none;
  padding: 0;
  width: 100%;
`;

export const ListItem = styled.li`
  padding: 8px;
  cursor: pointer;
  &:hover {
    background-color: #efefef;
  }
`;