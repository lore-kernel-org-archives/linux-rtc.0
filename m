Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:44601 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755406AbeAHGA5 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 8 Jan 2018 01:00:57 -0500
Received: by mail-ot0-f194.google.com with SMTP id g59so8409161otg.11
        for <linux-rtc@vger.kernel.org>; Sun, 07 Jan 2018 22:00:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <a63f2b482281004df854d8345cb18368224880b6.1514200190.git.baolin.wang@linaro.org>
References: <a63f2b482281004df854d8345cb18368224880b6.1514200190.git.baolin.wang@linaro.org>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Mon, 8 Jan 2018 14:00:56 +0800
Message-ID: <CAMz4kuL5TLMS7cKWcbmJ_0qNgiijNTxzuG4vzk=4DqyEvFKPYw@mail.gmail.com>
Subject: Re: [PATCH] rtc: Fix overflow when converting time64_t to rtc_time
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        linux-rtc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi Alexandre,

On 25 December 2017 at 19:10, Baolin Wang <baolin.wang@linaro.org> wrote:
> If we convert one large time values to rtc_time, in the original formula
> 'days * 86400' can be overflowed in 'unsigned int' type to make the formula
> get one incorrect remain seconds value. Thus we can use div_s64_rem()
> function to avoid this situation.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Could you apply this patch if there are no other comments? Thanks.

> ---
>  drivers/rtc/rtc-lib.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/rtc/rtc-lib.c b/drivers/rtc/rtc-lib.c
> index 1ae7da5..ad5bb21 100644
> --- a/drivers/rtc/rtc-lib.c
> +++ b/drivers/rtc/rtc-lib.c
> @@ -52,13 +52,11 @@ int rtc_year_days(unsigned int day, unsigned int month, unsigned int year)
>   */
>  void rtc_time64_to_tm(time64_t time, struct rtc_time *tm)
>  {
> -       unsigned int month, year;
> -       unsigned long secs;
> +       unsigned int month, year, secs;
>         int days;
>
>         /* time must be positive */
> -       days = div_s64(time, 86400);
> -       secs = time - (unsigned int) days * 86400;
> +       days = div_s64_rem(time, 86400, &secs);
>
>         /* day of the week, 1970-01-01 was a Thursday */
>         tm->tm_wday = (days + 4) % 7;
> --
> 1.7.9.5
>



-- 
Baolin.wang
Best Regards
