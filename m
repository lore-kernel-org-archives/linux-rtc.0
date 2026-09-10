Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C3D49BD74;
	Thu, 10 Sep 2026 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050192; cv=none; b=YXNyfTTvkYIhDCzvb3rPAXT+ubw95x1MIBchZgw4tG36i6ARV2TQHDVjQDyxDuFsX6I7DDXi5FW1anjkipq47zkVJ6R1WS+1nBhAhxLIwJwrNgvOo55LBosMm1agL/Gg3Y0aytmuQAtpjROgonaz1fhiPHRiIyweZPyb+mHQXvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050192; c=relaxed/simple;
	bh=ti8kd7bEqkBT7HXe7Yim/PquTqtR73r9syJa0QU9N4E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oMlAxITCTKVPW+3gpgPrdYQ9gODyife7b0AbsL5unY/PB5vLvHJvHzmT11ewP9QPLU8Pegx6OA9DpqWP8IvmwgYox2c2i8bYMnGycLT4SJtAJCR+JMzyAC0mE+YtFZI3Qv7G4sJhtQbm6BffnMtJObKZG2piRVG0i9l8lRpR1yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=7WROJipb; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="7WROJipb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=OaoMGEiP4AsMRzVKZhmJSQKoGC7nrXJGkFzbJ+5Ffyk=; t=1789050191; x=1790259791; 
	b=7WROJipbB932NzD9i4EPpYZ5zoeKPnpe0570TvMYexS8+27gK9v6/nryei7AIQ6zW1VGCNnpsmt
	Qfm2zgOjpWBY79FIdliAmvRQ3JTDfLeh+bZDMgklVAKg3XHjU/7P/GBYBcHR6HkkUVFb4LLhfYPDD
	cBzZWuM2Q3w+/x+fxvooIYPneArAOtAs2FYvizMzTpfDjrNQkfGYwxJZMRXBCFTlEDzCkXG+1DZ3H
	0iPz3BxzmFSSoaqcEP6fRLWZ0gdhYlUu3wvJkVgtrCGlW4MGkcefDyKaw9k/ZDNJ6zdjcE16fne+H
	Z13ghxUAIAKfJm/m0+xGvnt0IY74HiIfDe+Q==;
Date: Thu, 10 Sep 2026 16:23:04 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: alexandre.belloni@bootlin.com, linux-rtc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: bd70528: properly enable wakeup
Message-ID: <20260910162304.25333671@kemnade.info>
In-Reply-To: <af4854a4-d626-4896-af62-312b49b94f71@gmail.com>
References: <20260910092558.1008998-1-andreas@kemnade.info>
	<af4854a4-d626-4896-af62-312b49b94f71@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2026 13:28:23 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 10/09/2026 12:25, Andreas Kemnade wrote:
> > Wakeup on RTC alarm now only accidentially works when wakeup for the power
> > button connected to the same PMIC is also enabled. Fix that by properly
> > specifying the wakeup irq.
> > 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>  
> 
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> Thanks!
> 
> By the way, I am not 100% sure all of the PMICs using this driver even 
> have a power button input. I suspect some doesn't (maybe bd71815). I 
> wouldn't be against Fixes -tag :)
> 
looking at mfd driver:

                 * BD71815 data-sheet does not list the power-button IRQ so we
                 * don't use it.
                 */
                button_irq = 0;
....

 if (button_irq) {
                ret = rohm_register_pwrbutton(&i2c->dev, button_irq,
                                              "bd71828-pwrkey", true, irq_domain);
                if (ret)
                        return ret;
        }
....
so you are right about the power button.
Sashiko wants some error-checking there, so I'll send a
v2 with a fixes-tag and error checking.

Regards,
Andreas
