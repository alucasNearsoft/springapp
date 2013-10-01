<%@ include file="/WEB-INF/views/include.jsp" %>
<!DOCTYPE html>

<html ng-app>
  <head><title><fmt:message key="title"/></title>
  <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/angularjs/1.0.8/angular.min.js"></script>
  <script type="text/javascript">
  function productsController($scope) {
	  //$scope.products = <c:out value="${model.products}"/>;
	  //$scope.products = [Description: Lamp;Price: 9.98, Description: Table;Price: 129.87, Description: Chair;Price: 39.35]; // output from / salida de : <c:out value="${model.products}"/>
	  //$scope.products = [{Description: "Lamp",Price : 9.98},{Description: "Table",Price: 129.87},{Description: "Chair",Price: 39.35}];  // working format / formato que funciona
	//  $scope.products = [ 
//	                       <c:forEach var="product" items="${model.products}">
//	                       {
//	                       description : "<c:out value="${product.description}" />",
//	                       price : <c:out value="${product.price}" />
//	                            },
//	                       </c:forEach>
//	                        ];
	    $scope.products = ${model.productsJson}; // JSP tag to get the model / tag de JSP para recibir info. del modelo
        uid = $scope.products.length + 1; // new element might have this id / id de posible nuevo elem.

        $scope.saveProduct = function() {
         
          if($scope.newproduct.id == null) {
            //if this is new, add it in array
            $scope.newproduct.id = uid++;
            $scope.products.push($scope.newproduct);
          } else {
            //for existing element, find this using id
            //and update it.
            for(i in $scope.products) {
              if($scope.products[i].id == $scope.newproduct.id) {
                $scope.products[i] = $scope.newproduct;
              }
            }
          }
         
          //clear the add product form
          $scope.newproduct = {};
        };

        $scope.remove = function(id) {
            
            //search product with given id and delete it
            for(i in $scope.products) {
                if($scope.products[i].id == id) {
                    $scope.products.splice(i,1);
                    $scope.newproduct = {};
                }
            }
        };

        $scope.edit = function(id) { 
        	//search product with given id and update it
            for(i in $scope.products) {
                if($scope.products[i].id == id) {
                    //we use angular.copy() method to create 
                    //copy of originial object
                    $scope.newproduct = angular.copy($scope.products[i]);
                }
            }
        };
        
  };
  </script>

  </head>
  
  <body>
    <h1><fmt:message key="heading"/></h1>
    <p><fmt:message key="greeting"/> <c:out value="${model.now}"/></p>
    <h3>Products</h3>
    <!--  Using JSP tags, commented  for now / Uso de etiquetas JSP, comentarizadas
    	<c:forEach items="${model.products}" var="prod">
      	  <c:out value="${prod.description}"/> <i>$<c:out value="${prod.price}"/></i><br><br>
    	</c:forEach>
    -->
    <!-- Use AngularJS / Uso de AngularJS -->
    <div ng-controller="productsController">
    <form >
      <label>Product</label> 
        <input type="text" name="description" ng-model="newproduct.description"/>
      <label>Price</label> 
        <input type="text" name="price" ng-model="newproduct.price"/>
      <input type="hidden" ng-model="newproduct.id" />
      <input type="button" value="Save" ng-click="saveProduct()" />
    </form>
     <table>
      <thead>
       <tr>
       <th>Description</th>
       <th>Price</th>
       <th>Action</th>
       </tr>
      </thead>
      <tbody>
       <tr ng-repeat="prod in products">
        <td>{{ prod.description }}</td>
        <td>$ {{ prod.price }}</td>
        <td>
         <a href="#" ng-click="edit(prod.id)">edit</a>
         <a href="#" ng-click="remove(prod.id)">delete</a>
        </td>
       </tr>
      </tbody>
     </table>
    </div>
    
    <br>
      <a href="<c:url value="priceincrease.htm"/>">Increase Prices</a>
    <br>
  </body>
  
</html>