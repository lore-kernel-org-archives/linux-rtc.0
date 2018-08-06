Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:45145 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeHFLO3 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 6 Aug 2018 07:14:29 -0400
MIME-Version: 1.0
References: <20180726134056.18273-1-alexandre.belloni@bootlin.com> <20180726134056.18273-9-alexandre.belloni@bootlin.com>
In-Reply-To: <20180726134056.18273-9-alexandre.belloni@bootlin.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 6 Aug 2018 11:06:07 +0200
Message-ID: <CAK8P3a121CrinzrXPZ86f=KkK9yfnVHF70MQQYt2VVr-6jCnGQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] rtc: remove struct rtc_task
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, Jul 26, 2018 at 3:42 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Include rtc_task members directly in rtc_timer member.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/rtc/interface.c | 8 ++++----
>  include/linux/rtc.h     | 9 ++-------
>  2 files changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
> index d0983ed6c842..a962540faf2e 100644
> --- a/drivers/rtc/interface.c
> +++ b/drivers/rtc/interface.c
> @@ -912,8 +912,8 @@ void rtc_timer_do_work(struct work_struct *work)
>                 timerqueue_del(&rtc->timerqueue, &timer->node);
>                 trace_rtc_timer_dequeue(timer);
>                 timer->enabled = 0;
> -               if (timer->task.func)
> -                       timer->task.func(timer->task.private_data);
> +               if (timer->func)
> +                       timer->func(timer->private_data);
>
>                 trace_rtc_timer_fired(timer);
>                 /* Re-add/fwd periodic timers */
> @@ -968,8 +968,8 @@ void rtc_timer_init(struct rtc_timer *timer, void (*f)(void *p), void *data)
>  {
>         timerqueue_init(&timer->node);
>         timer->enabled = 0;
> -       timer->task.func = f;
> -       timer->task.private_data = data;
> +       timer->func = f;
> +       timer->private_data = data;
>  }

>From what I can see, all remaining users pass the rtc_device pointer as
'private_data', so maybe make that explicit now instead of the void pointer?

      Arnd
