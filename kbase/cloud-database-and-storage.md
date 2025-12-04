### Database & Storage: Choosing the Right Tool for the Job

Google Cloud offers a suite of databases. Using the right one is critical for performance and cost.

| Database / Storage | Data Model             | Use Case                                                                                             | When to Choose It                                                                                             |
| ------------------ | ---------------------- | ---------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| **Firestore**      | NoSQL (Documents)      | User profiles, real-time chat, activity feeds, semi-structured data.                                 | You need rapid development, automatic scaling, and easy synchronization with web/mobile clients.              |
| **Cloud SQL**      | Relational (Postgres)  | **Your default choice.** E-commerce orders, financial data, user credentials, any structured data.     | You need ACID compliance, complex queries, joins, and the reliability of a traditional relational database.    |
| **Cloud Spanner**  | Relational (Global)    | Global financial ledgers, massive-scale inventory systems, multi-region applications.                | You need the consistency of SQL but at a global scale that exceeds Cloud SQL's limits. This is for huge apps. |
| **Bigtable**       | NoSQL (Wide-column)    | IoT sensor data, ad-tech analytics, monitoring metrics.                                              | You have massive (terabytes+) datasets with very high write and read throughput needs.                        |
| **BigQuery**       | Analytical Warehouse   | Business intelligence dashboards, log analysis, feeding data to ML models.                           | You need to run complex analytical queries on huge datasets. **It is not a transactional database.**          |
| **Cloud Storage**  | Object Storage         | User-uploaded images/videos, static assets, backups, data lake storage.                              | For storing unstructured files. Your application will store the *URL* to the object in a database like Cloud SQL. |
