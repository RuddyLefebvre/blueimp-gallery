<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="s" uri="http://www.jahia.org/tags/search" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>

<c:set var="videoNode" value="${currentNode.properties.source.node}"/>
<jcr:node path="${videoNode.path}/jcr:content" var="contentNode" />
<c:set var="mainType" value="${fn:replace(contentNode.properties['jcr:mimeType'].string, 'application', 'video')}"/>
<c:url var="videoUrl" value="${videoNode.url}" context="/"/>
<c:set var="dataSources" value="["/>
<c:set var="dataSources">${dataSources}{"href":"${videoUrl}", "type":"${mainType}"}</c:set>
<c:set var="dataSources">${dataSources}]</c:set>

<c:set var="posterUrl"/>
<c:if test="${not empty currentNode.properties.poster}">
    <c:url value="${currentNode.properties.poster.node.url}" context="/" var="posterUrl"/>
</c:if>

<a href="${videoUrl}" title="${currentNode.displayableName}" type="${mainType}"
   data-poster="${posterUrl}" data-sources="${fn:escapeXml(dataSources)}" data-gallery>
    <c:choose>
        <c:when test="${not empty currentNode.properties.poster}">
            <img src="${posterUrl}" alt="${currentNode.displayableName}">
        </c:when>
        <c:otherwise>
            ${currentNode.displayableName}
        </c:otherwise>
    </c:choose>
</a>