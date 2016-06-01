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
<template:include view="hidden.header"/>

<fmt:message key="blueimpnt_lightBox.edit.addLightBoxContent"/>
<template:module path="*" nodeTypes="blueimpnt:carouselImageItem blueimpnt:carouselVideoItem blueimpnt:carouselOnlineVideoItem blueimpnt:carouselImageFromFolder"/>

<c:if test="${not empty moduleMap.currentList}">
    <template:addResources>
        <script>
            function toggleEditCollapse${fn:replace(currentNode.identifier, '-', '')}() {
                if ($('#collaspeList_${currentNode.identifier}').hasClass('open')) {
                    $('#collaspeList_${currentNode.identifier}').hide();
                    $('#collaspeList_${currentNode.identifier}').removeClass('open');
                } else {
                    $('#collaspeList_${currentNode.identifier}').show();
                    $('#collaspeList_${currentNode.identifier}').addClass('open');
                }
            }
        </script>
    </template:addResources>

    <c:if test="${fn:length(jcr:getChildrenOfType(currentNode, 'blueimpnt:carouselImageFromFolder')) ne 0}">
        <div style="background-color: #d9edf7;color: #31708f;padding: 15px;margin-bottom: 20px;border: 1px solid transparent;border-radius: 4px;">
            <strong><fmt:message key="blueimpnt_lightBox.edit.title.information"/></strong>
            <p><fmt:message key="blueimpnt_lightBox.edit.title.informationAboutImagesFromFolder"/></p>
        </div>
    </c:if>

    <button type="button" class="button-placeholder" onclick="toggleEditCollapse${fn:replace(currentNode.identifier, '-', '')}()">
        <fmt:message key="blueimpnt_lightBox.edit.editLightBoxContent"/>
    </button>

    <div id="collaspeList_${currentNode.identifier}" style="display: none">
        <c:forEach items="${moduleMap.currentList}" var="subchild">
            <template:module node="${subchild}" editable="true" view="edit"/>
        </c:forEach>
    </div>
</c:if>