import { useState, useEffect } from "react";
import BasicModal from "./BasicModal";

const Payment = () => {
    const [total, setTotal] = useState([]);
    useEffect(() => {
        fetch('/purchase/total', {method: 'GET'})
            .then(response => response.json())
            .then(data => setTotal(data))
            .catch(error => console.error('Error fetching TOTAL', error));
    }, []);

    return (
        <div class="center">
            <h1>Payment Method</h1>
            <h2>Total: £{total}</h2>
            <div style={{gap: '1em', display: 'flex'}}>
                <BasicModal />
                <button style={{fontSize: '20px', padding: '5px'}}>Pay by cash</button>
            </div>
        </div>
    )
}

export default Payment;