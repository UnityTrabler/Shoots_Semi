package net.pay.listner;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;


/*@WebListener*/
public class AppContextListener implements ServletContextListener {

    private AutoRefundScheduler autoRefundScheduler;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
    	
        autoRefundScheduler = new AutoRefundScheduler();
        autoRefundScheduler.startScheduler();  
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {

    	if (autoRefundScheduler != null) {
            autoRefundScheduler.stopScheduler(); 
        }
    }
}