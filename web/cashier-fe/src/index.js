import React from 'react';
import ReactDOM from 'react-dom/client';
import "./index.css"
import StartPage from './components/Start';
import Purchases from './components/Purchase';
import Payment from './components/Payment';
import Scan from './components/Scan';
import reportWebVitals from './reportWebVitals';
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import MemberScan from './components/MembershipScan';

const Router = () => {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" exact element={<StartPage />} />
        <Route path="/purchase" element={<Purchases />} />
        <Route path="/scan" element={<Scan />} />
        <Route path="/payment" element={<Payment />}></Route>
        <Route path="/membership" element={<MemberScan />}></Route>
      </Routes>
    </BrowserRouter>
  )
}

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
    <Router />
  </React.StrictMode>
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
