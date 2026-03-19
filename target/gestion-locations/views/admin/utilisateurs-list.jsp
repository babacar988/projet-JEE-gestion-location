<%@ page contentType="text/html;charset=UTF-8" language="java" buffer="64kb" autoFlush="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html><html>
<head><title>Utilisateurs — ImmoGest</title><jsp:include page="../shared/head.jsp"/></head>
<body>
<jsp:include page="../shared/navbar.jsp"><jsp:param name="page" value="utilisateurs"/></jsp:include>
  <div class="header bg-primary pb-6"><div class="container-fluid"><div class="header-body">
    <div class="row align-items-center py-4">
      <div class="col-lg-6 col-7"><h6 class="h2 text-white d-inline-block mb-0">Utilisateurs</h6></div>
      <div class="col-lg-6 col-5 text-right">
        <a href="${pageContext.request.contextPath}/admin/utilisateurs?action=nouveau" class="btn btn-sm btn-neutral">
          <i class="ni ni-fat-add mr-1"></i>Ajouter
        </a>
      </div>
    </div>
    <!-- Onglets par rôle -->
    <div class="row mt-2"><div class="col">
      <ul class="nav nav-pills nav-fill flex-column flex-md-row" id="tabs-u">
        <li class="nav-item"><a class="nav-link active" href="#" onclick="fu('',this)">Tous</a></li>
        <li class="nav-item"><a class="nav-link" href="#" onclick="fu('ADMIN',this)">Admins</a></li>
        <li class="nav-item"><a class="nav-link" href="#" onclick="fu('PROPRIETAIRE',this)">Propriétaires</a></li>
        <li class="nav-item"><a class="nav-link" href="#" onclick="fu('LOCATAIRE',this)">Locataires</a></li>
      </ul>
    </div></div>
  </div></div></div>
  <div class="container-fluid mt--6">
    <div class="card shadow">
      <div class="table-responsive">
        <table class="table align-items-center table-flush" id="uTable">
          <thead class="thead-light">
            <tr><th>Utilisateur</th><th>Email</th><th>Téléphone</th><th>Rôle</th><th>Statut</th><th>Actions</th></tr>
          </thead>
          <tbody>
            <c:choose>
              <c:when test="${empty utilisateurs}">
                <tr><td colspan="6" class="text-center py-5 text-muted">Aucun utilisateur</td></tr>
              </c:when>
              <c:otherwise>
                <c:forEach var="u" items="${utilisateurs}">
                  <tr data-role="${u.role}">
                    <td>
                      <div class="d-flex align-items-center">
                        <span class="avatar avatar-sm rounded-circle bg-gradient-primary text-white mr-2"
                              style="font-size:11px;font-weight:700;display:flex;align-items:center;justify-content:center;width:32px;height:32px">
                          ${u.prenom.charAt(0)}${u.nom.charAt(0)}
                        </span>
                        <div>
                          <div class="font-weight-bold text-sm">${u.prenom} ${u.nom}</div>
                        </div>
                      </div>
                    </td>
                    <td class="text-sm">${u.email}</td>
                    <td class="text-sm">${not empty u.telephone ? u.telephone : '—'}</td>
                    <td>
                      <c:choose>
                        <c:when test="${u.role=='ADMIN'}"><span class="badge badge-danger badge-pill">Admin</span></c:when>
                        <c:when test="${u.role=='PROPRIETAIRE'}"><span class="badge badge-warning badge-pill">Propriétaire</span></c:when>
                        <c:otherwise><span class="badge badge-info badge-pill">Locataire</span></c:otherwise>
                      </c:choose>
                    </td>
                    <td>
                      <c:choose>
                        <c:when test="${u.actif}"><span class="badge badge-success badge-pill">Actif</span></c:when>
                        <c:otherwise><span class="badge badge-secondary badge-pill">Inactif</span></c:otherwise>
                      </c:choose>
                    </td>
                    <td>
                      <a href="${pageContext.request.contextPath}/admin/utilisateurs?action=modifier&id=${u.id}"
                         class="btn btn-sm btn-outline-primary"><i class="ni ni-settings"></i></a>
                      <a href="${pageContext.request.contextPath}/admin/utilisateurs?action=supprimer&id=${u.id}"
                         class="btn btn-sm btn-outline-danger"
                         onclick="return confirm('Supprimer cet utilisateur ?')"><i class="ni ni-fat-remove"></i></a>
                    </td>
                  </tr>
                </c:forEach>
              </c:otherwise>
            </c:choose>
          </tbody>
        </table>
      </div>
    </div>
    <footer class="footer pt-0"><div class="row"><div class="col"><p class="text-muted text-sm">ImmoGest &copy; 2025</p></div></div></footer>
  </div>
</div><!-- /.main-content -->
<jsp:include page="../shared/scripts.jsp"/>
<script>function fu(r,l){document.querySelectorAll('#uTable tbody tr').forEach(tr=>{tr.style.display=(!r||tr.dataset.role===r)?'':'none';});document.querySelectorAll('#tabs-u .nav-link').forEach(x=>x.classList.remove('active'));l.classList.add('active');return false;}</script>
</body></html>
