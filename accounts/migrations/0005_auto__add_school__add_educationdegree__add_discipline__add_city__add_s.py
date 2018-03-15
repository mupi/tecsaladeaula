# -*- coding: utf-8 -*-
from south.utils import datetime_utils as datetime
from south.db import db
from south.v2 import SchemaMigration
from django.db import models


class Migration(SchemaMigration):

    def forwards(self, orm):
        # Adding model 'School'
        db.create_table(u'accounts_school', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('name', self.gf('django.db.models.fields.CharField')(max_length=200)),
            ('school_type', self.gf('django.db.models.fields.CharField')(max_length=30, null=True, blank=True)),
            ('city', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['accounts.City'], null=True, blank=True)),
            ('education_degree', self.gf('django.db.models.fields.CharField')(max_length=50, null=True, blank=True)),
        ))
        db.send_create_signal(u'accounts', ['School'])

        # Adding model 'EducationDegree'
        db.create_table(u'accounts_educationdegree', (
            ('name', self.gf('django.db.models.fields.CharField')(max_length=70, primary_key=True)),
        ))
        db.send_create_signal(u'accounts', ['EducationDegree'])

        # Adding model 'Discipline'
        db.create_table(u'accounts_discipline', (
            ('name', self.gf('django.db.models.fields.CharField')(unique=True, max_length=200, primary_key=True)),
        ))
        db.send_create_signal(u'accounts', ['Discipline'])

        # Adding model 'City'
        db.create_table(u'accounts_city', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('code', self.gf('django.db.models.fields.CharField')(max_length=20)),
            ('name', self.gf('django.db.models.fields.CharField')(max_length=80)),
            ('uf', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['accounts.State'])),
        ))
        db.send_create_signal(u'accounts', ['City'])

        # Adding model 'State'
        db.create_table(u'accounts_state', (
            ('name', self.gf('django.db.models.fields.CharField')(max_length=50)),
            ('uf', self.gf('django.db.models.fields.CharField')(max_length=2, primary_key=True)),
            ('uf_code', self.gf('django.db.models.fields.CharField')(max_length=5)),
        ))
        db.send_create_signal(u'accounts', ['State'])

        # Adding field 'TimtecUser.business_email'
        db.add_column(u'accounts_timtecuser', 'business_email',
                      self.gf('django.db.models.fields.EmailField')(max_length=75, null=True, blank=True),
                      keep_default=False)

        # Adding field 'TimtecUser.state'
        db.add_column(u'accounts_timtecuser', 'state',
                      self.gf('django.db.models.fields.CharField')(max_length=50, null=True, blank=True),
                      keep_default=False)

        # Adding field 'TimtecUser.job_title'
        db.add_column(u'accounts_timtecuser', 'job_title',
                      self.gf('django.db.models.fields.CharField')(max_length=70, null=True, blank=True),
                      keep_default=False)

        # Adding M2M table for field level_of_education_taught on 'TimtecUser'
        m2m_table_name = db.shorten_name(u'accounts_timtecuser_level_of_education_taught')
        db.create_table(m2m_table_name, (
            ('id', models.AutoField(verbose_name='ID', primary_key=True, auto_created=True)),
            ('timtecuser', models.ForeignKey(orm[u'accounts.timtecuser'], null=False)),
            ('educationdegree', models.ForeignKey(orm[u'accounts.educationdegree'], null=False))
        ))
        db.create_unique(m2m_table_name, ['timtecuser_id', 'educationdegree_id'])

        # Adding M2M table for field school on 'TimtecUser'
        m2m_table_name = db.shorten_name(u'accounts_timtecuser_school')
        db.create_table(m2m_table_name, (
            ('id', models.AutoField(verbose_name='ID', primary_key=True, auto_created=True)),
            ('timtecuser', models.ForeignKey(orm[u'accounts.timtecuser'], null=False)),
            ('school', models.ForeignKey(orm[u'accounts.school'], null=False))
        ))
        db.create_unique(m2m_table_name, ['timtecuser_id', 'school_id'])

        # Adding M2M table for field disciplines on 'TimtecUser'
        m2m_table_name = db.shorten_name(u'accounts_timtecuser_disciplines')
        db.create_table(m2m_table_name, (
            ('id', models.AutoField(verbose_name='ID', primary_key=True, auto_created=True)),
            ('timtecuser', models.ForeignKey(orm[u'accounts.timtecuser'], null=False)),
            ('discipline', models.ForeignKey(orm[u'accounts.discipline'], null=False))
        ))
        db.create_unique(m2m_table_name, ['timtecuser_id', 'discipline_id'])


    def backwards(self, orm):
        # Deleting model 'School'
        db.delete_table(u'accounts_school')

        # Deleting model 'EducationDegree'
        db.delete_table(u'accounts_educationdegree')

        # Deleting model 'Discipline'
        db.delete_table(u'accounts_discipline')

        # Deleting model 'City'
        db.delete_table(u'accounts_city')

        # Deleting model 'State'
        db.delete_table(u'accounts_state')

        # Deleting field 'TimtecUser.business_email'
        db.delete_column(u'accounts_timtecuser', 'business_email')

        # Deleting field 'TimtecUser.state'
        db.delete_column(u'accounts_timtecuser', 'state')

        # Deleting field 'TimtecUser.job_title'
        db.delete_column(u'accounts_timtecuser', 'job_title')

        # Removing M2M table for field level_of_education_taught on 'TimtecUser'
        db.delete_table(db.shorten_name(u'accounts_timtecuser_level_of_education_taught'))

        # Removing M2M table for field school on 'TimtecUser'
        db.delete_table(db.shorten_name(u'accounts_timtecuser_school'))

        # Removing M2M table for field disciplines on 'TimtecUser'
        db.delete_table(db.shorten_name(u'accounts_timtecuser_disciplines'))


    models = {
        u'accounts.city': {
            'Meta': {'object_name': 'City'},
            'code': ('django.db.models.fields.CharField', [], {'max_length': '20'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '80'}),
            'uf': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['accounts.State']"})
        },
        u'accounts.discipline': {
            'Meta': {'object_name': 'Discipline'},
            'name': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '200', 'primary_key': 'True'})
        },
        u'accounts.educationdegree': {
            'Meta': {'object_name': 'EducationDegree'},
            'name': ('django.db.models.fields.CharField', [], {'max_length': '70', 'primary_key': 'True'})
        },
        u'accounts.school': {
            'Meta': {'object_name': 'School'},
            'city': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['accounts.City']", 'null': 'True', 'blank': 'True'}),
            'education_degree': ('django.db.models.fields.CharField', [], {'max_length': '50', 'null': 'True', 'blank': 'True'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '200'}),
            'school_type': ('django.db.models.fields.CharField', [], {'max_length': '30', 'null': 'True', 'blank': 'True'})
        },
        u'accounts.state': {
            'Meta': {'object_name': 'State'},
            'name': ('django.db.models.fields.CharField', [], {'max_length': '50'}),
            'uf': ('django.db.models.fields.CharField', [], {'max_length': '2', 'primary_key': 'True'}),
            'uf_code': ('django.db.models.fields.CharField', [], {'max_length': '5'})
        },
        u'accounts.timtecuser': {
            'Meta': {'object_name': 'TimtecUser'},
            'accepted_terms': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'biography': ('django.db.models.fields.TextField', [], {'blank': 'True'}),
            'business_email': ('django.db.models.fields.EmailField', [], {'max_length': '75', 'null': 'True', 'blank': 'True'}),
            'city': ('django.db.models.fields.CharField', [], {'max_length': '30', 'blank': 'True'}),
            'date_joined': ('django.db.models.fields.DateTimeField', [], {'default': 'datetime.datetime.now'}),
            'disciplines': ('django.db.models.fields.related.ManyToManyField', [], {'symmetrical': 'False', 'to': u"orm['accounts.Discipline']", 'null': 'True', 'blank': 'True'}),
            'email': ('django.db.models.fields.EmailField', [], {'unique': 'True', 'max_length': '75'}),
            'first_name': ('django.db.models.fields.CharField', [], {'max_length': '30', 'blank': 'True'}),
            'groups': ('django.db.models.fields.related.ManyToManyField', [], {'symmetrical': 'False', 'related_name': "u'user_set'", 'blank': 'True', 'to': u"orm['auth.Group']"}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'is_active': ('django.db.models.fields.BooleanField', [], {'default': 'True'}),
            'is_staff': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'is_superuser': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'job_title': ('django.db.models.fields.CharField', [], {'max_length': '70', 'null': 'True', 'blank': 'True'}),
            'last_login': ('django.db.models.fields.DateTimeField', [], {'default': 'datetime.datetime.now'}),
            'last_name': ('django.db.models.fields.CharField', [], {'max_length': '30', 'blank': 'True'}),
            'level_of_education_taught': ('django.db.models.fields.related.ManyToManyField', [], {'symmetrical': 'False', 'to': u"orm['accounts.EducationDegree']", 'null': 'True', 'blank': 'True'}),
            'occupation': ('django.db.models.fields.CharField', [], {'max_length': '30', 'blank': 'True'}),
            'password': ('django.db.models.fields.CharField', [], {'max_length': '128'}),
            'picture': ('django.db.models.fields.files.ImageField', [], {'max_length': '100', 'blank': 'True'}),
            'school': ('django.db.models.fields.related.ManyToManyField', [], {'symmetrical': 'False', 'to': u"orm['accounts.School']", 'null': 'True', 'blank': 'True'}),
            'site': ('django.db.models.fields.URLField', [], {'max_length': '200', 'blank': 'True'}),
            'state': ('django.db.models.fields.CharField', [], {'max_length': '50', 'null': 'True', 'blank': 'True'}),
            'user_permissions': ('django.db.models.fields.related.ManyToManyField', [], {'symmetrical': 'False', 'related_name': "u'user_set'", 'blank': 'True', 'to': u"orm['auth.Permission']"}),
            'username': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '30'})
        },
        u'auth.group': {
            'Meta': {'object_name': 'Group'},
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '80'}),
            'permissions': ('django.db.models.fields.related.ManyToManyField', [], {'to': u"orm['auth.Permission']", 'symmetrical': 'False', 'blank': 'True'})
        },
        u'auth.permission': {
            'Meta': {'ordering': "(u'content_type__app_label', u'content_type__model', u'codename')", 'unique_together': "((u'content_type', u'codename'),)", 'object_name': 'Permission'},
            'codename': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'content_type': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['contenttypes.ContentType']"}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '50'})
        },
        u'contenttypes.contenttype': {
            'Meta': {'ordering': "('name',)", 'unique_together': "(('app_label', 'model'),)", 'object_name': 'ContentType', 'db_table': "'django_content_type'"},
            'app_label': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'model': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'})
        }
    }

    complete_apps = ['accounts']