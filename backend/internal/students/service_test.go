package students_test

import (
	"net/http"
	"testing"

	"github.com/tejesh-kaliki/worksheet-checker/backend/internal/testsupport"
)

func TestCreateStudent(t *testing.T) {
	t.Run("success", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/students",
			`{"name":"Asha","roll_number":"1"}`, token)
		if w.Code != http.StatusCreated {
			t.Fatalf("status = %d, want 201 (%s)", w.Code, w.Body.String())
		}
		body := decode(t, w.Body.Bytes())
		if body["name"] != "Asha" || body["roll_number"] != "1" {
			t.Fatalf("body = %+v", body)
		}
	})

	t.Run("conflict on duplicate roll_number", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")
		testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/students",
			`{"name":"Asha","roll_number":"1"}`, token)

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/students",
			`{"name":"Bala","roll_number":"1"}`, token)
		if w.Code != http.StatusConflict {
			t.Fatalf("status = %d, want 409 (%s)", w.Code, w.Body.String())
		}
	})

	t.Run("not_found for another owner's class", func(t *testing.T) {
		setupTest(t)
		_, tokenA := createUser(t, "a@b.com")
		_, tokenB := createUser(t, "b@b.com")
		classID := createClass(t, tokenA, "C")

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/students",
			`{"name":"Asha","roll_number":"1"}`, tokenB)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404", w.Code)
		}
	})

	t.Run("validation", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")

		w := testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/students",
			`{"name":"","roll_number":""}`, token)
		if w.Code != http.StatusBadRequest {
			t.Fatalf("status = %d, want 400", w.Code)
		}
	})
}

func TestListStudents(t *testing.T) {
	t.Run("success", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")
		testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/students",
			`{"name":"Asha","roll_number":"1"}`, token)

		w := testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/classes/"+classID+"/students", "", token)
		if w.Code != http.StatusOK {
			t.Fatalf("status = %d, want 200", w.Code)
		}
	})
}

func TestGetStudent(t *testing.T) {
	t.Run("success", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")
		created := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/students",
			`{"name":"Asha","roll_number":"1"}`, token).Body.Bytes())

		w := testsupport.DoJSONAuth(router, http.MethodGet, "/api/v1/classes/"+classID+"/students/"+created["id"].(string), "", token)
		if w.Code != http.StatusOK {
			t.Fatalf("status = %d, want 200", w.Code)
		}
	})

	t.Run("not_found", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")

		w := testsupport.DoJSONAuth(router, http.MethodGet,
			"/api/v1/classes/"+classID+"/students/00000000-0000-0000-0000-000000000000", "", token)
		if w.Code != http.StatusNotFound {
			t.Fatalf("status = %d, want 404", w.Code)
		}
	})
}

func TestUpdateStudent(t *testing.T) {
	t.Run("success", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")
		created := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/students",
			`{"name":"Asha","roll_number":"1"}`, token).Body.Bytes())

		w := testsupport.DoJSONAuth(router, http.MethodPut, "/api/v1/classes/"+classID+"/students/"+created["id"].(string),
			`{"name":"Asha K","roll_number":"2"}`, token)
		if w.Code != http.StatusOK {
			t.Fatalf("status = %d, want 200 (%s)", w.Code, w.Body.String())
		}
	})
}

func TestDeleteStudent(t *testing.T) {
	t.Run("success", func(t *testing.T) {
		setupTest(t)
		_, token := createUser(t, "owner@b.com")
		classID := createClass(t, token, "C")
		created := decode(t, testsupport.DoJSONAuth(router, http.MethodPost, "/api/v1/classes/"+classID+"/students",
			`{"name":"Asha","roll_number":"1"}`, token).Body.Bytes())

		w := testsupport.DoJSONAuth(router, http.MethodDelete, "/api/v1/classes/"+classID+"/students/"+created["id"].(string), "", token)
		if w.Code != http.StatusNoContent {
			t.Fatalf("status = %d, want 204", w.Code)
		}
	})
}
