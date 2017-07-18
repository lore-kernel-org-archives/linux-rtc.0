Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from smtprelay0053.hostedemail.com ([216.40.44.53]:36249 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751402AbdGRRtI (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 18 Jul 2017 13:49:08 -0400
Message-ID: <1500399695.25934.25.camel@perches.com>
Subject: Re: [PATCH 1/4] rtc-lib: Add rtc_show_time(const char *prefix_msg)
From: Joe Perches <joe@perches.com>
To: Mark Salyzyn <salyzyn@android.com>, linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        linux-pm@vger.kernel.org, a.zummo@towertech.it,
        alexandre.belloni@free-electrons.com, linux-rtc@vger.kernel.org
Date: Tue, 18 Jul 2017 10:41:35 -0700
In-Reply-To: <20170718172525.114514-1-salyzyn@android.com>
References: <20170718172525.114514-1-salyzyn@android.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Tue, 2017-07-18 at 10:25 -0700, Mark Salyzyn wrote:
> Go directly to the rtc for persistent wall clock time and print.
> Useful if REALTIME is required to be logged in a low level power
> management function or when clock activities are suspended.  An
> aid to permit user space alignment of kernel activities.
[]
> diff --git a/include/linux/rtc.h b/include/linux/rtc.h
[]
> @@ -22,6 +22,11 @@ extern int rtc_year_days(unsigned int day, unsigned int month, unsigned int year
>  extern int rtc_valid_tm(struct rtc_time *tm);
>  extern time64_t rtc_tm_to_time64(struct rtc_time *tm);
>  extern void rtc_time64_to_tm(time64_t time, struct rtc_time *tm);
> +#ifdef CONFIG_RTC_SHOW_TIME
> +extern void rtc_show_time(const char *prefix_msg);
> +#else
> +#define rtc_show_time(prefix_msg)

It's generally better to use a static inline to avoid
misuses in newly added code in the !CONFIG_RTC_SHOW_TIME
compile path when CONFIG_RTC_SHOW_TIME may not be compiled.

static inline void rtc_show_time(const char *prefix_msg)
{
}
