require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")

import "bootstrap"
import "../stylesheets/application"
import '../../../lib/assets/javascripts/confirm';
import "../views/transfer_requests/components/form"
import Swal from 'sweetalert2';

window.Swal = Swal;
