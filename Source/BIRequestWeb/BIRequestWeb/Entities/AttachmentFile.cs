using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BiRequestWeb.Entities
{
    public class AttachmentFile
    {
        public long Id { get; set; }
        public long? RequestId { get; set; }
        public string FileName { get; set; }
        public string ContentType { get; set; }
        public long? ContentLength { get; set; }
        public byte[] FileContent { get; set; }
        public DateTime? CreatedOn { get; set; }
    }
}