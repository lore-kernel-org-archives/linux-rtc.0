Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6651C2AA
	for <linux-rtc@vger.kernel.org>; Tue, 18 Aug 2026 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787063756; cv=pass; b=WuUND3kwJvhYX0UIKj5VM1iYul7SxbEobEF6cAHvCQioZs+rkrNaD6RvJEZG5iU43fRoaqmn5hDZjYZcAM0aQwIf5YPaTzm0omjtJhP31z3VRr1O40wFsh6xzl8ysfgcCIySQfQcXLpmeJgu0JTfDsypgdvfkMvZ4HAfbdpJ9g8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787063756; c=relaxed/simple;
	bh=eK/OAvD5T3nAKg67fnkrfSipcDgxi3KnfRYcdUcekeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bPnACdMmWnGcNVFV778dBKagPyRUHc5JOzflC5bJQ9RRC5XrnrbI2+PeXPdmzRYOQ/eskHagqmx11eor7Y5hhkYrd9nSWF39HFOCqHbEQAFV1svnoYaA+M7/xzV60Uomd3U4oAKR4zexl8FfnQGdkDFLxp7jv+++YsAMPS/5Q9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlqfDp57; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlqfDp57"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-482938466a7so3088258f8f.1
        for <linux-rtc@vger.kernel.org>; Tue, 18 Aug 2026 07:35:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787063753; cv=none;
        d=google.com; s=arc-20260327;
        b=l7kctP2Wgo9X/q/ZK6cZnm0++4TXUF878oFJIfKFjFCUcezsXNRCfFSbDxHptmAT6Q
         l058rMnln7843OLN4PVAah7wNGDfJJzPwdrmyBFxPWI4hIN660nhXSAkiGE9cNaQuBCh
         vg5dP3lXe4p49DrU2eljGdTTufUcsNZJoq7DtqBkuWXE5BlIEtd/rqJQrW2rLSWnfnTu
         rwEb9v+hYtwMYNq5PRsPfDGJ/NrD7SLncBtevz8wLFIHfxYSYzKz92rD5Uw5mMMpTzvd
         HxTSZxPV/AVYmt2ZY8SRpAyfUlWU53vGkGAEhFxOhdqW+CU9bbYtamMFEaPgZHGibIFh
         LTaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MVCvZ3mYxT1SbXEXSshkIkro7sM7s+vt95nIOeUmgDs=;
        fh=sjQWCRsSuZNjapFJQUsst/TipjqvC6CRfnPBp85lHc4=;
        b=sg9xiSSzXmZ44LwuhE4q4Sty00XXkOS92HDgHEIuVYlhSARG1c6aS4lIfCaaHI8Hu0
         rWtzXFc0B30gwG5Uk3trPfuXsAMPRN3gT3AZywtR5cLF0e56OMImkw2Ty0MnFYAbeZPe
         OOwk3MeYOkYWaHRzNuZ2ZbNkYB2BudwUfdfm9MdBG3QNXazbYsseBFLS7r5mhtuG8bB5
         nw/7QbmBaHlsAEzTStLeZbTJU5h3gl95mYqX5+b3igln+7ICMjIVd+Ovblhygl/fpiA/
         ElJYHLeF3glU+8C1WQQyyOcoSH0wpNTjnwpWkuY+WRauGQBVAJLcxo/MJcIb+SPV3Y3T
         +Mvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787063753; x=1787668553; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MVCvZ3mYxT1SbXEXSshkIkro7sM7s+vt95nIOeUmgDs=;
        b=DlqfDp57i/lLeOaBqF9kekje2l/CW/2I3oNPwNIjDtKLctzc5RlpZkKpQs7BSSr/AE
         BcIDqRmiveEeUcq9iMDhkrllYmw4AEePUazKMJA5vG8eBgMPhMvzKd/io9XjkCexZFJM
         IvG7+Bjw5edbntqftIjRmveoMay0sMuhJbadM4cAvdqZC1tU5mee64GUwT3tt1Vj5Vdd
         6tsGI3Dn2f73dnwC5R1qdUQz0UDjGrxMoYaqH/HYDjKxlKW7xm9ToO4enu8MfZlfAsi1
         aXMaWksIPCPARWgzJP2vxy1F9Ur+QeJv4l1UHX1MWdwzQIPhxq5M5qxphWnDjfQLmbFL
         y+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787063753; x=1787668553;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MVCvZ3mYxT1SbXEXSshkIkro7sM7s+vt95nIOeUmgDs=;
        b=s4i30BNeLRdnbJ6dYCPHYMaJkYkqypEmtWgyfuWm3vyswnETWuMHSV8kdPyGdvQ0g6
         71UWJMfYvxMrForKcFPPqi2E+jAGLmwK++j4RgUguGxiku4mUBClOYirFfGQk2AK9FLi
         Sae+wlwLz/x4x6tu5w8NJblhhf33o1ZsariA/T7cQsi5BJM/5MFxMf30YgI16Hdl4doB
         Itb7+5PFLzdg0ObNrXCSS1NwnvLVXxBnluaRwmfldJVz3meVpi0h0dkwn+KJht8BcEl5
         +/Ab/GOPqW74ffB4WBB40JHNH0jQMVIzorU7HPU0zf6wJNhYiTWCCu64T/E5h8kioqKw
         lJBw==
X-Forwarded-Encrypted: i=1; AHgh+Rp9T25g+A1/6oSiLfAWR4wiNWKQdtMYR9TLCKjAa9qhuzPJNzL+hrkQJUDGA1fg1Udm6AI1d219n1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDQyc8K27AqD1BezhkELtBQHGeJlHtIzTGjBi80yzM2K0ZnuC1
	T5Fymrxz+31ICZytJ7A3WOijf5O8wvvQ3UUaXaREZVnWRSwnc5ZodgJqbGwZkF66X/CgB1V62Ia
	P4rtEAPHKHKp+PJ7nXhZAEkY37dyPiR8=
X-Gm-Gg: AR+sD11DhSwx7OESL52pBlpSHj9fDbIqnFayBAWdNzcPokHz0M5HwWe0TvR+k9Iq7Xi
	W68QDOpI2+DWqod16K0FWztS3CKNCLyV2Y5WdB72DblFRM1XIJQ5A6fHunCHAojhARosk27P2ML
	4O5jbcra3NfyOCV0xH8engctpb4WFttaVcakqVMdaFuBd+feV8j1sER011zLMg6RhGOs6enyBqh
	6N+rZgspS8V3TkehUNHq8/1MnGyhQ8N88DIo10w0TCJ8ZlkDnxf33LJQ43x4tdtY3O/6F6jI6PA
	f5xH1a6ZZ4Ot+Rhw344vdViz3AeZYUPOXBG1lM6ZlJL1S6l+xV8DIG45BNbnyCSSOC0GgBTAc0Z
	uAp21UpaluLw72B+hbizDA2eezLr2lPWgpt2Jp8Uu/cqBonmYNMMzAtD8BXgnn4o=
X-Received: by 2002:a05:6000:3109:b0:47f:e748:3ae3 with SMTP id
 ffacd0b85a97d-4816070bf1fmr51894142f8f.3.1787063752390; Tue, 18 Aug 2026
 07:35:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706175138.12587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260706175138.12587-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <aoQvrL8cnnK7uxqw@ninjato>
In-Reply-To: <aoQvrL8cnnK7uxqw@ninjato>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 18 Aug 2026 15:35:25 +0100
X-Gm-Features: AcwNN1XrTnnWQE0HKkObvyxUFu7X0N_3i8zbJm_vjvyoQd8C8mij4hA0jhrhrcM
Message-ID: <CA+V-a8sG47PCuKTR-K=sci2SOEWjYRDOWRWeamYysvNO0XAuNQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/12] rtc: rzn1: fix weekday underflow when alarm
 crosses month boundary
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-rtc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Prabhakar <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

Thank you for the review.

On Tue, Aug 18, 2026 at 11:10=E2=80=AFAM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> On Mon, Jul 06, 2026 at 06:51:29PM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > In rzn1_rtc_set_alarm(), the driver attempts to calculate the weekday
> > for an alarm by computing the day delta between the alarm time and the
> > current time:
> >
> >     days_ahead =3D tm->tm_mday - tm_now.tm_mday;
> >     wday =3D (tm_now.tm_wday + days_ahead) % 7;
> >
> > However, if an alarm is scheduled for the beginning of the next month
> > while the current time is at the end of the month (e.g., current day is
> > 31, alarm day is 1), `tm->tm_mday - tm_now.tm_mday` results in a negati=
ve
> > value (-30). Since `days_ahead` is an unsigned int, this underflows to =
a
> > large positive number, leading to an incorrect `wday` being written to
> > the RZN1_RTC_ALW register. As a result, the alarm fails to fire.
> >
> > Fix this by utilizing the already computed `alarm` time64_t timestamp.
> > Convert it back into an rtc_time struct via rtc_time64_to_tm(), which
> > automatically handles month boundaries and correctly populates the
> > `tm_wday` field.
> >
> > Fixes: b5ad1bf00d2c4 ("rtc: rzn1: Add alarm support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> These messages look a bit LLM-generated. Is this true? What about the
> code?
>
Yes the commit message was fine tuned by an LLM, but not the code.

> > -     days_ahead =3D tm->tm_mday - tm_now.tm_mday;
> > -     wday =3D (tm_now.tm_wday + days_ahead) % 7;
> > +     rtc_time64_to_tm(alarm, &alarm_tm);
>
> This conversion is superfluous, we already have 'tm'? So, I think we can
> skip the whole conversion block here and use?
>
>         writel(BIT(tm->tm_wday), rtc->base + RZN1_RTC_ALW);
>
> Only lightly tested, please double check.
>
Yes it does the trick. I tested with the below script:

#!/bin/sh
set -x
DEV=3D/dev/rtc0

for d in "2026-08-31 23:58:00" "2026-04-30 23:58:00" "2028-02-28
23:58:00" "2027-02-27 23:58:00"; do
    echo "=3D=3D=3D Testing boundary at: $d =3D=3D=3D"
    hwclock --set --date=3D"$d" -f $DEV
    hwclock -f $DEV --hctosys

    # -m mem/standby would actually suspend the board, which is disruptive
    # in an automated test loop. Instead, block on the alarm IRQ directly
    # via select(2) on the rtc fd -- this is what confirms the alarm
    # actually asserts, not just that it was armed.
    timeout 150 rtcwake -m on -d $DEV -s 130
    echo "exit: $?"
done

Without the fix I get timeouts as expected.

Cheers,
Prabhakar
