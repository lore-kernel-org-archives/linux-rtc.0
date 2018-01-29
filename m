Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39514 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751436AbeA2V7V (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 29 Jan 2018 16:59:21 -0500
Date: Mon, 29 Jan 2018 13:59:19 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Michael Grzeschik <mgr@pengutronix.de>
Cc: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jdelvare@suse.com,
        kernel@pengutronix.de, Denis.Osterland@diehl.com
Subject: Re: [PATCH 4/4] rtc: isl1208: add support for isl1219 with hwmon for
 tamper detection
Message-ID: <20180129215919.GA17988@roeck-us.net>
References: <20180123121801.4214-1-m.grzeschik@pengutronix.de>
 <20180123121801.4214-5-m.grzeschik@pengutronix.de>
 <20180123182254.GA27379@roeck-us.net>
 <20180124090333.r5o2mzpm4q536w4r@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180124090333.r5o2mzpm4q536w4r@pengutronix.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Wed, Jan 24, 2018 at 10:03:33AM +0100, Michael Grzeschik wrote:
[ ... ]
> > > +
> > > diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
> > > index fc337c317c673..a12b3c2b2a18c 100644
> > > --- a/Documentation/hwmon/sysfs-interface
> > > +++ b/Documentation/hwmon/sysfs-interface
> > > @@ -702,6 +702,13 @@ intrusion[0-*]_alarm
> > >  		the user. This is done by writing 0 to the file. Writing
> > >  		other values is unsupported.
> > >  
> > > +intrusion[0-*]_timestamp
> > > +		Chassis intrusion detection
> > > +		YYYY-MM-DD HH:MM:SS UTC (ts.sec): intrusion detected
> > > +		RO
> > > +		The corresponding timestamp on which the intrustion
> > > +		was detected.
> > > +
> > 
> > Sneaky. Nack. You don't just add attributes to the ABI because you want it,
> > without serious discussion, and much less so hidden in an RTC driver
> > (and even less as unparseable attribute).
> 
> Right; but it was not meant to be sneaky. I should have stick to my first
> thought and label this patch RFC. Sorry for that.
> 
> > In addition to that, I consider the attribute unnecessary. The intrusion
> > already generates an event which should be sufficient for all practical
> > purposes.
> 
> Would it make sense in between the other sysfs attributes of this driver?
> 
I don't understand what you mean with that, sorry.

>From an ABI perspective, the attibute doesn't add value since it is
highly device specific (or at least it is the only chip I am aware of
which reports such a time stamp). Feel free to add the attribute to the
driver and document it, but not as part of the hwmon ABI. In that
case I would be inclined to accept it. However, keep in mind that
your version, reporting a human readable date/time, would effectively
preclude it from ever making it into the ABI.

Guenter
