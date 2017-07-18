Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34655 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbdGRRZM (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 18 Jul 2017 13:25:12 -0400
Received: by mail-pf0-f173.google.com with SMTP id q85so14550868pfq.1
        for <linux-rtc@vger.kernel.org>; Tue, 18 Jul 2017 10:25:12 -0700 (PDT)
From: Mark Salyzyn <salyzyn@android.com>
To: linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        linux-pm@vger.kernel.org, a.zummo@towertech.it,
        alexandre.belloni@free-electrons.com, linux-rtc@vger.kernel.org,
        Mark Salyzyn <salyzyn@android.com>
Subject: [PATCH 0/4] PM / Suspend: Print wall time
Date: Tue, 18 Jul 2017 10:24:22 -0700
Message-Id: <20170718172443.114401-1-salyzyn@android.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Helpful for post-mortem analysis to synchronize CLOCK_MONOTONIC
kernel logs with CLOCK_REALTIME user space logs.  Post-mortem
analysis for Battery and Power diagnosis.  Improved reporting
of suspension times against the rtc wallclock, which is
persistent even at the lowest power management states.

analyze_suspend.py requires a configured kernel to debug, these
prints can remain in a field product with CONFIG_RTC_TIME_SHOW.

Sincerely -- Mark Salyzyn
