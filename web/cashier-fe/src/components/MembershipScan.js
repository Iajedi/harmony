import { MembershipScanner } from "./Membership";
import Kirby from "./Kirby";
import { Link } from "react-router-dom";

function MemberScan() {
    return (
        <div class="center">
            <h2 style={{ textAlign: 'center' }}>Scan Harmony card</h2>
            <MembershipScanner />
            <Kirby />
            <Link to="/">
                <button type="button">
                    Skip
                </button>
            </Link>
        </div>
    )
}

export default MemberScan;