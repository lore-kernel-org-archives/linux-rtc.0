Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5390C3CA487
	for <linux-rtc@vger.kernel.org>; Thu, 20 Aug 2026 09:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787219618; cv=pass; b=hUcbbBKQHuujaozu9hkeYzS71LdP9RUMgLvFdJp30sIq0temSdEcUVzNsTHi6tfIVSRsl1KNT+bdaS0Jbc7sdaLuJhVipQhXY0uE7p3b3H6upMUoIzte+cVf8AsG7MNgtvtfNZMMYeNgaoTIowoK6Ts5lP7XRYr0jNix/Ouq/DQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787219618; c=relaxed/simple;
	bh=4uFua/1SLZPtH58HJboPUy8UA2xsPzLVyw6OMpvii0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nBLNCEcRlfr1L4d3x908vqkX7eXJUyrxYpyAEHLNdCwrFBO7g97KIZaD/I/9pg99rsAc5Y0d3RQjuoO+tGQ9/ojstx6xDges39NZ0q6bDa7ISEi6eiG0ppEggU8vOjmplCbOQZOHJ4hGvAu0S8vWPOcGLZ6CSrLBYZHc/WXxde4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCeuOq8L; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCeuOq8L"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-471eeac43bfso1625799f8f.3
        for <linux-rtc@vger.kernel.org>; Thu, 20 Aug 2026 02:53:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787219612; cv=none;
        d=google.com; s=arc-20260327;
        b=U4Eaw0rMzkWlHAXoSoQj1YSnx9c//6hRkBvpd1KXutS3l2XW/TAF6j5QpsywE6Ij5s
         TnMwXQenIq4YZFEMC/NRfEE465OKGc3+5AdHcL6nj8YsClWjI69QYlgYzbv7FcTbq1//
         O2UQ3lrBA3ssXN5K0TP4C+Udr3dLXIwoWI4ZJ1LgnW9PBOvHZy+RU1E18qjud1hM1mP6
         kxb3z3l09bNLBnkfP834UozMuXKgkmSGl5PpbxKD/yl3FuRMBwclxd+y7Q2J8boqhZaP
         N5wUOtHPOoGcthC2szy/L5C1BZ4oeWa59O/TkaQ5oz4ZjpPYELJphlp382akDhN8fM/T
         Knxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4uFua/1SLZPtH58HJboPUy8UA2xsPzLVyw6OMpvii0M=;
        fh=zTgeMjcZt51uTQDzrGAzKOAzJg4sOKDG2HhBl8st0c4=;
        b=W8D7BjMJiVtp7dvGaYkocL+NvIkeEvSIqUTAqGNx976z4apiIA5GQ8kwCDWye3CqQ/
         jX/Z28oQJyjAB+WQHeu1ZrQ4CRM2Cg9re9XGaMXEcHede3viC02mGxvPUEhZmGuF8VHB
         y216zwLoNhvZ0XtL4ySDbJDJqsE/IFAyuFY3WDacqJ3/ydHswhj1wVdOqSTNfILvCWUk
         DNbmWA2riPos5FKPBFwwdK1uNopM/OEmC9FlQHgeoqYFBfVqL75JXaPiRMaV+O5xrikT
         LkY1aBpXvmDq5I8UWSDuSmVGFs8fl0rSfL3Y1PTLjoMUY1y9P3izkbejLcYbYZ4jg0By
         6/5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787219612; x=1787824412; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4uFua/1SLZPtH58HJboPUy8UA2xsPzLVyw6OMpvii0M=;
        b=OCeuOq8L/hFALKirAgzAB5gMVR/19MbuNtrhrKETJYScT+IL8ayv8329DgBIz+ls/n
         bu4NXfj0gtbTyPNl/AeSLyiXeFbfeToSzOkUxITeMFwlqd1kvK9vLhWNKnHmxvw3M2q6
         FHPUGAJ0DY16BhgSIGjlXXpYxmBQyGHJSU2zliyF9TpZ8zBwzKO///UYKey3yfXAdeUd
         xOvKSpKVgAtbVn2qn5p/G6BROqYqT/Y+5aFaFrIatt67FB0iKaTnOVCeHyvQ+DTHVd9H
         sltPZksCfpKrVYz4I0TF9+UrP7KDClcWufICY4tPtQTZzAXlJgjerH9HlgnD4MZgLKky
         pe5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787219612; x=1787824412;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4uFua/1SLZPtH58HJboPUy8UA2xsPzLVyw6OMpvii0M=;
        b=iDzUtqGfSAruILYmhyKTCZlxfg8p8jULBZ5Xp4c3+9PC6jAReuiGpdYmuhihzZVQyG
         UUnvrjP3FUv+cTia64ht8yN6issIYQd1t/qtF0WGzFJrDfpQ9Eajz9Bn34kScFL7spYu
         XnqPnaMXCD6ltx0jVGUceKuelBSMKGoLkTrgIt/4ebY5nVkhLfGpypDgKj3Unl8rIBxW
         DFgIAcMm9iSiEOAL8I40kY7/7oxGQaoaYpXtPg2sYmm9xwnWD/Cw4+RKSIS8p/ckosmf
         S1yryWNhySMwKcaYAh7K0yvmyjvvfrAJdvpvi+gQmB0SxNszQIjJShmrwLb04whs4r2V
         I/RQ==
X-Forwarded-Encrypted: i=1; AHgh+RqUbEVVDxsIa6jeixg82QLXi9K4sVRC4mMWcAjhY3EOH5kYtt37e+F5NCdsUh8OsgmZBNk+4GKqxk4=@vger.kernel.org
X-Gm-Message-State: AFuF++l+vvcSv4zjMo8dUIqCOAA7LSugbXjFxGGaiLMyFm96bAlU8wqZ
	YzyuyYIUP7NhBIJNEO233+egpCqmBdEtJ7h63SGKlZxmj/zoxTJhDiBZhz4QyWc9okbZwbF7uaS
	vw5CqWBtLcU1KlyKNI6IHG00huhvvyh8=
X-Gm-Gg: AR+sD13+4Jv0RFgDlt4xeCqpvwsGHy6LkMc5cHrhK3wlFp/RT+hIs0Tk07X8Ip63jwO
	tQagS5I4gj0jjynV4A6AsZjr8aYVeSOCCwmJNCkPGIZbFmgc2uViehsrHdvQgexb6zJqUd66UEB
	/tlBwOk5HllFTw3NQNIBv+iJsTxfXA4kBJfa/jTiGFwujOeW2DB5Pc4/WyVwajenLOpYkMqv6Br
	rQkZX6I7KInFin1ANWac/jlP6TBWsAs/u+7EwVo3w0Ubuc+hD8Jt9swMmglHyWVqCTZ2RS5bm4I
	FTL9WSvtEkEOaa+zgYKcYT41VzoKQxDelb7zxdiTtkqILGQNClT3DzqxhcpKOddWu19kglelB6N
	OXo4jFJ/r3/hMg4WkrnYZjl9PlUddd7m0F8ELzkEwRg==
X-Received: by 2002:a5d:59a7:0:b0:47d:fc20:e7ab with SMTP id
 ffacd0b85a97d-482b1e844b5mr20227184f8f.4.1787219612250; Thu, 20 Aug 2026
 02:53:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819103926.2136712-15-prabhakar.mahadev-lad.rj@bp.renesas.com> <aoWsDIfmFgkRpDje@shikoro>
In-Reply-To: <aoWsDIfmFgkRpDje@shikoro>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 20 Aug 2026 10:53:05 +0100
X-Gm-Features: AcwNN1WOm3KalsDKNgN_Ouo-4r3cQno4NAzdUolNyABXgRrO98d1tOFgxu9R-9E
Message-ID: <CA+V-a8sZ5nf21z6Ku-3xUaG98=ZwJ-4Z4OcVkkzL8+pg1w1r0w@mail.gmail.com>
Subject: Re: [PATCH v4 14/15] rtc: rzn1: Drop trailing comma from OF match
 table sentinel
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-rtc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Prabhakar <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

Thank you for the review.

On Wed, Aug 19, 2026 at 2:13=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> On Wed, Aug 19, 2026 at 11:39:25AM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Drop the trailing comma from the final empty entry in the RZN1 RTC OF
> > match table and mark it explicitly as the sentinel.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Could be folded into patch 13 in my book, but not insisting on that:
>
I'll keep this as is for now.

Cheers,
Prabhakar

> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
