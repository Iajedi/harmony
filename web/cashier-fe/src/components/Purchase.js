import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';

function removeProduct(id) {
    fetch('/purchase/delete/' + id, { method: 'DELETE' })
        .catch(error => console.error("Error deleting item " + error));
    window.location.reload();
}

function Purchases() {
    const [purchases, setPurchases] = useState([]);
    const [total, setTotal] = useState([]);

    useEffect(() => {
        fetch('/purchase')
            .then(response => response.json())
            .then(data => setPurchases(data))
            .catch(error => console.error('Error fetching PURCHASES', error));
    }, []);

    useEffect(() => {
        fetch('/purchase/total', { method: 'GET' })
            .then(response => response.json())
            .then(data => setTotal(data))
            .catch(error => console.error('Error fetching TOTAL', error));
    }, []);

    return (
        <div>
            <h1 style={{ transform: 'translate(11%, 0)' }}>Products</h1>
            <ul style={{ left: '50%', transform: 'translate(7%, 0)' }}>
                <table>
                    <thead>
                        <tr>
                            <th>Product Name</th>
                            <th>Price (£)</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        {purchases.map(p => (
                            <tr key={p.id}>
                                <td>{p.name}</td>
                                <td>{p.price}</td>
                                <td>
                                    <button onClick={() => removeProduct(p.id)}>Delete</button>
                                </td>
                            </tr>
                        ))}
                    </tbody>
                </table>
                <p style={{ fontSize: '28px'}}><strong>Total: £{total}</strong></p>
                <div style={{ gap: '1em', display: 'flex' }}>
                    <Link to="/scan">
                        <button type="button" style={{ marginBottom: '10px' }}>Add item</button>
                    </Link>
                    <Link to="/payment">
                        <button type="button">Finish and pay</button>
                    </Link>
                </div>


            </ul>
        </div>
    )
}

export default Purchases;