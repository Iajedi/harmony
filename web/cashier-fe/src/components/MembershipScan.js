import { MembershipScanner } from "./Membership";
import { Link } from "react-router-dom";

function MemberScan() {
    return (
        <div class="center">
            <h2>Scan Harmony card</h2>
            <MembershipScanner />
            <Link to="/">
                <button type="button">
                    Skip
                </button>
            </Link>
        </div>
    )
}

export default MemberScan;