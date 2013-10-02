package com.companyname.springapp.web;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.companyname.springapp.domain.Product;
import com.companyname.springapp.service.ProductManager;

@Controller
public class InventoryController {

    protected final Log logger = LogFactory.getLog(getClass());

    // tells the application context to inject an instance of productManager here
    @Autowired
    private ProductManager productManager;
    
    @RequestMapping(value="/hello.htm")
    public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String now = (new Date()).toString();
        logger.info("Returning hello view with " + now);

        Map<String, Object> myModel = new HashMap<String, Object>();
        myModel.put("now", now);
        myModel.put("products", this.productManager.getProducts());
        
        // json format / formato json
        final OutputStream out = new ByteArrayOutputStream();
        final ObjectMapper mapper = new ObjectMapper();
        mapper.writeValue(out, this.productManager.getProducts());
        final byte[] data = ((ByteArrayOutputStream) out).toByteArray();
        myModel.put("productsJson", new String(data));

        return new ModelAndView("hello", "model", myModel);
    }
    
    @RequestMapping(value = "/productsjson", method = RequestMethod.GET)
    public @ResponseBody
     List<Product> getProductsJson()
      throws JsonGenerationException, JsonMappingException, IOException {
        return this.productManager.getProducts();
    }
    
    public void setProductManager(ProductManager productManager) {
        this.productManager = productManager;
    }
}