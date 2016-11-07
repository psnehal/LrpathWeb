package org.ncibi.resource.util;


import java.io.IOException;

import org.hibernate.Session;
import org.ncibi.db.EntityManagers;
import org.ncibi.db.PersistenceSession;
import org.ncibi.db.PersistenceUnit;
import org.ncibi.db.ws.Task;
import org.ncibi.db.ws.TaskType;
import org.ncibi.hibernate.SessionProcedure;
import org.ncibi.hibernate.Sessions;
import org.ncibi.task.TaskStatus;

public class ChipEnrichLinkUrlTest
{
	public static void main(String[] args) throws IOException
	{
		ChipEnrichLinkUrlTest ct = new ChipEnrichLinkUrlTest();
		ct.testLogging();
	}
    
    public void testLogging()
    {
        PersistenceSession persistence = new PersistenceUnit(EntityManagers
                    .newEntityManagerFromProject("task"));
        
        String uuid ="12345667989";
        String name = "test2test2test2";
        
        final Task tk = new Task();
       tk.setUuid("12345667989");
       tk.setStatus(TaskStatus.DONE);
       tk.setTaskType(TaskType.LRPATH_JAVAX);
       
        Sessions.withSession(persistence.session(), new SessionProcedure()
        {
            @Override
            public void apply(Session session)
            {
                session.saveOrUpdate(tk);
            }
        });
        
        
      
            final String hql = "from ws.Task where uuid = '" + uuid+ "'";
            Task  link = null;

            try
            {
                link = persistence.hqlQuery(hql).single();
            }
            catch (Exception e)
            {
                link = null;
            }
            System.out.println(link.getStatus());

             
       
        
        
    }

	

	
}
