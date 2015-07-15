Return-Path: <rtc-linux+bncBDSMJPPV7QFRB4NZS6WQKGQEYQVF5UQ@googlegroups.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com. [32.97.110.159])
        by gmr-mx.google.com with ESMTPS id ra16si341172pac.0.2015.07.14.21.09.20
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 14 Jul 2015 21:09:21 -0700 (PDT)
Received: from /spool/local
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <rtc-linux@googlegroups.com> from <stewart@linux.vnet.ibm.com>;
	Tue, 14 Jul 2015 22:09:20 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
	by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 82CBF1FF0042
	for <rtc-linux@googlegroups.com>; Tue, 14 Jul 2015 22:00:27 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t6F48mQE46006298
	for <rtc-linux@googlegroups.com>; Tue, 14 Jul 2015 21:08:48 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t6F49GSI003731
	for <rtc-linux@googlegroups.com>; Tue, 14 Jul 2015 22:09:16 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Michael Neuling <mikey@neuling.org>, rtc-linux@googlegroups.com,
        Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Neelesh Gupta <neelegup@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [rtc-linux] Re: [PATCH] rtc/rtc-opal: Enable alarms only when opal
 supports tpo
In-Reply-To: <1436860708-17058-1-git-send-email-vaibhav@linux.vnet.ibm.com>
References: <1436860708-17058-1-git-send-email-vaibhav@linux.vnet.ibm.com>
Date: Wed, 15 Jul 2015 14:09:15 +1000
Message-ID: <m3egkaukno.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Vaibhav Jain <vaibhav@linux.vnet.ibm.com> writes:
> rtc-opal driver provides support for rtc alarms via
> timed-power-on(tpo). However some Power platforms like BML use a fake
> rtc clock and don't support tpo. Such platforms are indicated by the
> missing 'has-tpo' property in the device tree.
>
> Current implementation however enables callback for
> rtc_class_ops.read/set alarm irrespective of the tpo support from the
> platform. This results in a failed opal call when kernel tries to read
> an existing alarms via opal_get_tpo_time during rtc device registration.
>
> This patch fixes this issue by setting opal_rtc_ops.read/set_alarm
> callback pointers only when tpo is supported.
>
> Acked-by: Michael Neuling <mikey@neuling.org>
> Acked-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>

FWIW I'm updating OPAL docs with this. The TPO calls aren't actually
documented :(

In future, it'd be great if there was an accompanying skiboot patch
updating the documentation there too.

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
