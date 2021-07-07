require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")

import "bootstrap"
import "../stylesheets/application"
import '../../../lib/assets/javascripts/confirm';
import Swal from 'sweetalert2';

window.Swal = Swal;
