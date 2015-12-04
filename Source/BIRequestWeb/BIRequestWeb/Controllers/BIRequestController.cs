using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using BIRequestWeb.DAL;
using BIRequestWeb.Models;

namespace BIRequestWeb.Controllers
{
    public class BiRequestController : Controller
    {
        readonly Repository _repo = new Repository();
        readonly BiRequestTransformer _transformer = new BiRequestTransformer();

        public ActionResult Index()
        {
            return View(_transformer.ToModels(_repo.Get()));
        }

        public ActionResult Details(int id)
        {
            return View(_transformer.ToModel(_repo.GetById(id)));
        }

        [Authorize(Roles = "admin")]
        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Create(BiRequest requestData)
        {
            try
            {
                _repo.Insert(_transformer.ToEntity(requestData));
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        public ActionResult Edit(int id)
        {
            return View(_transformer.ToModel(_repo.GetById(id)));
        }

        [HttpPost]
        public ActionResult Edit(int id, BiRequest biRequest)
        {
            try
            {
                _repo.Update(id, _transformer.ToEntity(biRequest));
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        public ActionResult Delete(int id)
        {
            return View(_transformer.ToModel(_repo.GetById(id)));
        }

        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                _repo.Delete(id);
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}