  <!-- 실패 메세지를 출력(modal) -->
    <div id="modalOverlay" class="modal-overlay" ></div>
    <!-- 모달 창 -->
    <div id="myModal" class="modal" style="display:none;">
        <div class="modal-header">
            Notification
            <span id="closeModal" class="modal-close">&times;</span>
        </div>
        <div class="modal-body">
            <p id="modalMessage">${msg}</p>
        </div>
        <div class="modal-button">
            <button id="closeModalButton">Close</button>
        </div>
    </div>            