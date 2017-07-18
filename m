Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:41124 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751963AbdGRWg4 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 18 Jul 2017 18:36:56 -0400
Date: Wed, 19 Jul 2017 00:36:49 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Mark Salyzyn <salyzyn@android.com>
cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org,
        a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
        linux-rtc@vger.kernel.org, andy.shevchenko@gmail.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Mark Salyzyn <salyzyn@google.com>,
        Thierry Strudel <tstrudel@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3 1/4] time: rtc-lib: Add rtc_show_time(const char
 *prefix_msg)
In-Reply-To: <20170718221607.132539-1-salyzyn@android.com>
Message-ID: <alpine.DEB.2.20.1707190035270.2425@nanos>
References: <20170718221607.132539-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Tue, 18 Jul 2017, Mark Salyzyn wrote:

> Go directly to the rtc for persistent wall clock time and print.
> Useful if REALTIME is required to be logged in a low level power
> management function or when clock activities are suspended.  An
> aid to permit user space alignment of kernel activities.

Can you please spare the churn and wait until the discussion about the
general issues is resolved before sending out yet another set of patches,
which do not address any of the real important questions?

Thanks,

	tglx
