import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';
part 'booked_ticket.g.dart';

@SqfEntityBuilder(myDbModel)
const myDbModel = SqfEntityModel(
  modelName: 'BookedTicket',
  databaseName: 'booked_ticket.db',
  databaseTables: [tickets],
  bundledDatabasePath: null,
);

const tickets = SqfEntityTable(
  tableName: 'ticket',
  primaryKeyName: 'ticketID',
  primaryKeyType: PrimaryKeyType.integer_unique,
  useSoftDeleting: false,
  fields: [
    SqfEntityField('movieID', DbType.integer),
    SqfEntityField('customerName', DbType.text),
    SqfEntityField('email', DbType.text),
    SqfEntityField('customerID', DbType.integer),
    SqfEntityField('contactNumber', DbType.integer),
    SqfEntityField('movieTitle', DbType.text),
    SqfEntityField('movieStartTime', DbType.integer),
    SqfEntityField('movieEndTime', DbType.integer),
  ],
);
