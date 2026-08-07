"""
Synthetic sample generator for the Worksheet & Quiz Answer Checker project.

Design notes (also mirrored into README.md alongside the output):
- All questions are ORIGINAL, written in the style of JEE (Physics/Maths) and
  CBSE (Class 10 Science) exams. No verbatim content from real NTA/CBSE papers
  is used, to respect copyright and the project's synthetic-data-only constraint.
  Syllabus topic names (e.g. "Electrostatics", "Life Processes") are public
  curriculum terms, not copyrighted text.
- Each question carries an answer_key sized to its type (exact match + variants
  for numeric/fill-in, distractor reasoning for MCQ, a rubric for open-response).
- Each question gets 15 simulated student responses drawn from a FIXED,
  documented distribution, each carrying a gold label:
    7  correct            (varied phrasing/format, still right)
    3  incorrect_misconception (a specific, plausible wrong reasoning)
    2  boundary_or_partial (format edge case for closed types; partial credit
                             territory for open-response)
    1  malformed_blank
    1  malformed_gibberish_or_offtopic
  This label is NOT fed to the grader under test -- it's the gold standard used
  to score grader accuracy afterwards (this is what gives us a real "before/after"
  number to report, and a place to point at documented failure modes).
"""

import json
import random
import os

random.seed(42)

OUT_DIR = "/home/claude/samples/output"
os.makedirs(OUT_DIR, exist_ok=True)

# ---------------------------------------------------------------------------
# Response-shape templates per question type
# ---------------------------------------------------------------------------

def mcq_responses(correct_letter, distractor_letters):
    wrong = [l for l in distractor_letters if l != correct_letter]
    picks = []
    # 7 correct - vary how the student writes it
    correct_forms = [correct_letter, correct_letter.lower(), f"({correct_letter})",
                      f"Option {correct_letter}", f"{correct_letter}.", f"ans: {correct_letter}",
                      f"I think {correct_letter}", f"It's {correct_letter}"]
    for f in correct_forms:
        picks.append((f, "correct"))
    # 3 incorrect via misconception - pick a specific wrong option, repeated with variation
    misconception_letter = wrong[0]
    for f in [misconception_letter, f"({misconception_letter})", f"Option {misconception_letter}"]:
        picks.append((f, "incorrect_misconception"))
    # 2 boundary/partial - multi-select or ambiguous marking
    other_wrong = wrong[1] if len(wrong) > 1 else wrong[0]
    picks.append((f"{correct_letter} or {other_wrong}", "boundary_or_partial"))
    picks.append((f"{correct_letter}{other_wrong}", "boundary_or_partial"))
    # 1 blank, 1 gibberish
    picks.append(("", "malformed_blank"))
    picks.append(("asdkj not sure lol", "malformed_gibberish_or_offtopic"))
    return picks


def true_false_responses(correct_bool):
    correct_str = "True" if correct_bool else "False"
    wrong_str = "False" if correct_bool else "True"
    picks = []
    for f in [correct_str, correct_str.lower(), correct_str[0], f"{correct_str}.", "Yes" if correct_bool else "No", "correct" if correct_bool else "incorrect", "T" if correct_bool else "F", f"definitely {correct_str.lower()}"]:
        picks.append((f, "correct"))
    for f in [wrong_str, wrong_str.lower(), wrong_str[0]]:
        picks.append((f, "incorrect_misconception"))
    picks.append(("Partially true", "boundary_or_partial"))
    picks.append(("Not always", "boundary_or_partial"))
    picks.append(("", "malformed_blank"))
    picks.append(("what does this even mean", "malformed_gibberish_or_offtopic"))
    return picks


def numeric_responses(correct_value, unit, wrong_value):
    picks = []
    forms = [str(correct_value), f"{correct_value} {unit}", f"{correct_value}{unit}",
              f"≈{correct_value}", f"{correct_value}.0" if isinstance(correct_value, int) else str(correct_value),
              f"about {correct_value}", f"{correct_value} approx", f"~{correct_value}"]
    for f in forms:
        picks.append((f, "correct"))
    for f in [str(wrong_value), f"{wrong_value} {unit}", f"{wrong_value}{unit}"]:
        picks.append((f, "incorrect_misconception"))
    # boundary: right number wrong unit / wrong precision
    picks.append((f"{correct_value} wrong-unit-placeholder", "boundary_or_partial"))
    picks.append((f"{correct_value}00", "boundary_or_partial"))
    picks.append(("", "malformed_blank"))
    picks.append(("dunno, didn't attempt", "malformed_gibberish_or_offtopic"))
    return picks


def fill_in_responses(correct_answer, wrong_answer):
    picks = []
    forms = [correct_answer, correct_answer.lower(), correct_answer.upper(),
              f" {correct_answer} ", f"{correct_answer}.", f"the answer is {correct_answer}",
              correct_answer.capitalize(), f"I believe it's {correct_answer}"]
    for f in forms:
        picks.append((f, "correct"))
    for f in [wrong_answer, wrong_answer.lower(), wrong_answer.capitalize()]:
        picks.append((f, "incorrect_misconception"))
    picks.append((f"{correct_answer} (maybe)", "boundary_or_partial"))
    picks.append((f"{correct_answer} or {wrong_answer}", "boundary_or_partial"))
    picks.append(("", "malformed_blank"))
    picks.append(("???", "malformed_gibberish_or_offtopic"))
    return picks


def open_response_answers(full_points, partial_points, wrong_points, offtopic_points):
    picks = []
    for f in full_points[:7] if len(full_points) >= 7 else (full_points * 7)[:7]:
        picks.append((f, "correct"))
    for f in (wrong_points * 3)[:3]:
        picks.append((f, "incorrect_misconception"))
    for f in (partial_points * 2)[:2]:
        picks.append((f, "boundary_or_partial"))
    picks.append(("", "malformed_blank"))
    picks.append((offtopic_points[0] if offtopic_points else "not sure, skipping this one", "malformed_gibberish_or_offtopic"))
    return picks


def build_student_rows(question_id, response_pairs):
    rows = []
    for i, (answer_text, label) in enumerate(response_pairs, start=1):
        rows.append({
            "student_id": f"S{i:02d}",
            "question_id": question_id,
            "answer_text": answer_text,
            "gold_label": label,
        })
    random.shuffle(rows)
    # re-number student_id after shuffle so ordering doesn't leak the label pattern
    for i, r in enumerate(rows, start=1):
        r["student_id"] = f"S{i:02d}"
    return rows

print("helpers loaded")

# ---------------------------------------------------------------------------
# JEE Physics -- 20 questions: 6 MCQ, 4 True/False, 4 numeric, 3 fill-in, 3 open-response
# ---------------------------------------------------------------------------

jee_physics = [
    {
        "id": "phy-001", "subject": "JEE Physics", "topic": "Kinematics", "type": "mcq", "marks": 4,
        "question_text": "A particle starts from rest and moves with constant acceleration. If it covers 45 m in the 5th second, what is its acceleration?",
        "options": {"A": "5 m/s²", "B": "10 m/s²", "C": "20 m/s²", "D": "2.5 m/s²"},
        "answer_key": {"correct_answer": "B",
            "distractor_reasoning": {
                "A": "Confuses distance in nth second formula with average velocity.",
                "C": "Forgets the factor of 1/2 in the nth-second displacement formula.",
                "D": "Divides the correct answer by 4 by mis-substituting n=5 as n²."}},
        "_responses": mcq_responses("B", ["A", "B", "C", "D"]),
    },
    {
        "id": "phy-002", "subject": "JEE Physics", "topic": "Electrostatics", "type": "mcq", "marks": 4,
        "question_text": "Two point charges +q and -q are separated by distance d. The electric field at the midpoint of the line joining them is directed:",
        "options": {"A": "Perpendicular to the line joining the charges", "B": "From +q to -q", "C": "From -q to +q", "D": "Zero"},
        "answer_key": {"correct_answer": "B",
            "distractor_reasoning": {
                "C": "Reverses the direction convention for field lines (which go from + to -).",
                "D": "Incorrectly assumes fields from equal-magnitude opposite charges cancel at the midpoint.",
                "A": "Confuses this dipole setup with the field along the perpendicular bisector of two like charges."}},
        "_responses": mcq_responses("B", ["A", "B", "C", "D"]),
    },
    {
        "id": "phy-003", "subject": "JEE Physics", "topic": "Thermodynamics", "type": "mcq", "marks": 4,
        "question_text": "In an adiabatic process for an ideal gas, which quantity remains constant?",
        "options": {"A": "Temperature", "B": "Pressure", "C": "Entropy", "D": "Volume"},
        "answer_key": {"correct_answer": "C",
            "distractor_reasoning": {
                "A": "Confuses adiabatic with isothermal process.",
                "B": "Confuses adiabatic with isobaric process.",
                "D": "Confuses adiabatic with isochoric process."}},
        "_responses": mcq_responses("C", ["A", "B", "C", "D"]),
    },
    {
        "id": "phy-004", "subject": "JEE Physics", "topic": "Modern Physics", "type": "mcq", "marks": 4,
        "question_text": "The photoelectric effect demonstrates that light behaves as:",
        "options": {"A": "A continuous wave only", "B": "A stream of particles (photons)", "C": "A medium requiring aether", "D": "A purely magnetic phenomenon"},
        "answer_key": {"correct_answer": "B",
            "distractor_reasoning": {
                "A": "This is exactly what the wave model predicts incorrectly (no threshold frequency) -- a common conceptual trap.",
                "C": "Confuses this with disproven 19th-century aether theory, unrelated to photoelectric effect.",
                "D": "Not a standard misconception but a plausible-sounding distractor for guessing students."}},
        "_responses": mcq_responses("B", ["A", "B", "C", "D"]),
    },
    {
        "id": "phy-005", "subject": "JEE Physics", "topic": "Optics", "type": "mcq", "marks": 4,
        "question_text": "A convex lens forms a real, inverted, diminished image. The object must be placed:",
        "options": {"A": "Between focus and lens", "B": "At focus", "C": "Beyond twice the focal length (2F)", "D": "At 2F"},
        "answer_key": {"correct_answer": "C",
            "distractor_reasoning": {
                "D": "At exactly 2F the image is same-size, not diminished -- a common off-by-one-case error.",
                "A": "Object between focus and lens gives a virtual, magnified image, not real/diminished.",
                "B": "At focus the image forms at infinity, not diminished."}},
        "_responses": mcq_responses("C", ["A", "B", "C", "D"]),
    },
    {
        "id": "phy-006", "subject": "JEE Physics", "topic": "Rotational Mechanics", "type": "mcq", "marks": 4,
        "question_text": "The moment of inertia of a solid sphere about its diameter is:",
        "options": {"A": "(2/5)MR²", "B": "(2/3)MR²", "C": "MR²", "D": "(1/2)MR²"},
        "answer_key": {"correct_answer": "A",
            "distractor_reasoning": {
                "B": "This is the moment of inertia of a hollow (spherical shell), not solid, sphere.",
                "D": "This is the moment of inertia of a solid disc/cylinder, a commonly confused formula.",
                "C": "This is for a point mass or ring, not a solid sphere."}},
        "_responses": mcq_responses("A", ["A", "B", "C", "D"]),
    },
    {
        "id": "phy-007", "subject": "JEE Physics", "topic": "Kinematics", "type": "true_false", "marks": 2,
        "question_text": "True or False: If the velocity of an object is zero at an instant, its acceleration at that instant must also be zero.",
        "answer_key": {"correct_answer": False,
            "explanation": "False -- e.g. a ball thrown up has zero velocity at the peak but non-zero (gravitational) acceleration."},
        "_responses": true_false_responses(False),
    },
    {
        "id": "phy-008", "subject": "JEE Physics", "topic": "Electrostatics", "type": "true_false", "marks": 2,
        "question_text": "True or False: Electric field lines can intersect each other at a point where the field is zero.",
        "answer_key": {"correct_answer": False,
            "explanation": "False -- field lines never intersect at all, since the field direction at any point must be unique."},
        "_responses": true_false_responses(False),
    },
    {
        "id": "phy-009", "subject": "JEE Physics", "topic": "Waves", "type": "true_false", "marks": 2,
        "question_text": "True or False: The speed of sound in air increases with an increase in humidity.",
        "answer_key": {"correct_answer": True,
            "explanation": "True -- moist air has lower density than dry air (water vapour is lighter than N2/O2), so sound travels faster."},
        "_responses": true_false_responses(True),
    },
    {
        "id": "phy-010", "subject": "JEE Physics", "topic": "Modern Physics", "type": "true_false", "marks": 2,
        "question_text": "True or False: In the photoelectric effect, increasing the intensity of incident light increases the maximum kinetic energy of emitted electrons.",
        "answer_key": {"correct_answer": False,
            "explanation": "False -- intensity increases the number of photoelectrons emitted, not their maximum kinetic energy, which depends only on frequency."},
        "_responses": true_false_responses(False),
    },
    {
        "id": "phy-011", "subject": "JEE Physics", "topic": "Kinematics", "type": "numeric", "marks": 4,
        "question_text": "A stone is dropped from a height of 80 m (g = 10 m/s²). Find the time taken to reach the ground, in seconds, correct to one decimal place.",
        "answer_key": {"correct_answer": "4.0", "unit": "s", "tolerance_note": "accept 4 or 4.0"},
        "_responses": numeric_responses("4.0", "s", "8.0"),
    },
    {
        "id": "phy-012", "subject": "JEE Physics", "topic": "Electrostatics", "type": "numeric", "marks": 4,
        "question_text": "Two charges of 2 μC and 3 μC are placed 3 m apart in vacuum. Find the magnitude of the electrostatic force between them in mN (k = 9×10^9 N·m²/C², correct to one decimal place).",
        "answer_key": {"correct_answer": "6.0", "unit": "mN", "tolerance_note": "accept 6 or 6.0"},
        "_responses": numeric_responses("6.0", "mN", "18.0"),
    },
    {
        "id": "phy-013", "subject": "JEE Physics", "topic": "Thermodynamics", "type": "numeric", "marks": 4,
        "question_text": "One mole of an ideal monatomic gas is heated at constant volume, raising its temperature by 100 K. Find the heat absorbed in joules (R = 8.3 J/mol·K, correct to nearest integer).",
        "answer_key": {"correct_answer": "1245", "unit": "J", "tolerance_note": "accept 1245 ± 5"},
        "_responses": numeric_responses("1245", "J", "830"),
    },
    {
        "id": "phy-014", "subject": "JEE Physics", "topic": "Optics", "type": "numeric", "marks": 4,
        "question_text": "An object is placed 30 cm from a convex lens of focal length 10 cm. Find the image distance from the lens in cm.",
        "answer_key": {"correct_answer": "15", "unit": "cm", "tolerance_note": "accept 15 or 15.0"},
        "_responses": numeric_responses("15", "cm", "7.5"),
    },
    {
        "id": "phy-015", "subject": "JEE Physics", "topic": "Units and Measurement", "type": "fill_in", "marks": 2,
        "question_text": "The SI unit of magnetic flux is the ____.",
        "answer_key": {"correct_answer": "weber", "accepted_variants": ["Weber", "Wb"]},
        "_responses": fill_in_responses("weber", "tesla"),
    },
    {
        "id": "phy-016", "subject": "JEE Physics", "topic": "Modern Physics", "type": "fill_in", "marks": 2,
        "question_text": "The phenomenon in which a nucleus splits into two lighter nuclei with release of energy is called ____.",
        "answer_key": {"correct_answer": "nuclear fission", "accepted_variants": ["fission"]},
        "_responses": fill_in_responses("nuclear fission", "nuclear fusion"),
    },
    {
        "id": "phy-017", "subject": "JEE Physics", "topic": "Waves", "type": "fill_in", "marks": 2,
        "question_text": "The apparent change in frequency of a wave due to relative motion between source and observer is called the ____ effect.",
        "answer_key": {"correct_answer": "Doppler", "accepted_variants": ["doppler"]},
        "_responses": fill_in_responses("Doppler", "Zeeman"),
    },
    {
        "id": "phy-018", "subject": "JEE Physics", "topic": "Electrostatics", "type": "open_response", "marks": 3,
        "question_text": "State Gauss's law and explain why it is useful for calculating the electric field of symmetric charge distributions.",
        "answer_key": {"rubric_points": [
            "States Gauss's law: total electric flux through a closed surface = enclosed charge / ε0",
            "Notes the closed surface is a chosen 'Gaussian surface', not a physical object",
            "Explains it simplifies field calculation when symmetry lets E be pulled out of the flux integral (spherical/cylindrical/planar symmetry)"]},
        "_responses": open_response_answers(
            full_points=[
                "Gauss's law states the flux through a closed surface equals the enclosed charge divided by epsilon-0. For symmetric charge distributions we can choose a Gaussian surface where E is constant and pull it out of the integral, making the calculation simple.",
                "Total electric flux through any closed surface = Q_enclosed / ε0. It's useful because for symmetric charges (spherical, cylindrical, planar) we can pick a surface where the field is uniform over the surface, so we avoid doing a hard integral.",
            ],
            partial_points=[
                "Gauss's law relates flux to enclosed charge. It's used for symmetric problems.",
                "Flux through closed surface = Q/epsilon0. Makes calculating field easier for spheres.",
            ],
            wrong_points=[
                "Gauss's law says the electric field is always constant on any surface you draw.",
                "Gauss's law is used to calculate the force between two point charges directly.",
            ],
            offtopic_points=["This is about magnetism and Faraday's law I think"],
        ),
    },
    {
        "id": "phy-019", "subject": "JEE Physics", "topic": "Thermodynamics", "type": "open_response", "marks": 3,
        "question_text": "Explain the difference between an isothermal and an adiabatic process for an ideal gas.",
        "answer_key": {"rubric_points": [
            "Isothermal: temperature constant, requires heat exchange with surroundings",
            "Adiabatic: no heat exchange (Q=0), temperature changes as work is done",
            "Notes the adiabatic PV curve is steeper than the isothermal one (different exponent, gamma vs 1)"]},
        "_responses": open_response_answers(
            full_points=[
                "In an isothermal process, temperature stays constant and the gas exchanges heat with surroundings to compensate for work done. In an adiabatic process, no heat is exchanged (Q=0), so temperature changes as the gas does work. The adiabatic PV curve is steeper than the isothermal one.",
                "Isothermal means constant T with heat flowing in/out to keep it that way. Adiabatic means Q=0, so any work done changes the internal energy and temperature. Adiabatic curves are steeper on a PV diagram than isothermal curves.",
            ],
            partial_points=[
                "Isothermal is constant temperature, adiabatic is no heat exchange.",
                "In isothermal T doesn't change. In adiabatic, no heat goes in or out.",
            ],
            wrong_points=[
                "Isothermal means no heat exchange and adiabatic means constant temperature.",
                "Both processes are the same except adiabatic happens faster.",
            ],
            offtopic_points=["This is about the ideal gas equation PV=nRT"],
        ),
    },
    {
        "id": "phy-020", "subject": "JEE Physics", "topic": "Rotational Mechanics", "type": "open_response", "marks": 3,
        "question_text": "Explain why a figure skater spins faster when they pull their arms inward.",
        "answer_key": {"rubric_points": [
            "Identifies conservation of angular momentum (L = Iω) as no external torque acts",
            "Explains pulling arms in reduces moment of inertia I",
            "Concludes angular velocity ω must increase to keep L constant"]},
        "_responses": open_response_answers(
            full_points=[
                "By conservation of angular momentum, L = Iω stays constant since there's no external torque. Pulling arms in reduces the moment of inertia I, so angular velocity ω must increase to compensate.",
                "Angular momentum is conserved because no external torque acts on the skater. When arms are pulled in, the moment of inertia decreases, so the spin rate (angular velocity) increases to keep L the same.",
            ],
            partial_points=[
                "Angular momentum stays the same. Arms in means less inertia so faster spin.",
                "It's conservation of angular momentum -- less mass distributed away from the axis means faster rotation.",
            ],
            wrong_points=[
                "The skater spins faster because pulling arms in reduces air resistance.",
                "It's due to conservation of linear momentum, since the arms move inward.",
            ],
            offtopic_points=["This is related to centripetal force on the skater's feet"],
        ),
    },
]

print(f"jee_physics: {len(jee_physics)} questions")

# ---------------------------------------------------------------------------
# JEE Mathematics -- 20 questions: 6 MCQ, 4 True/False, 4 numeric, 3 fill-in, 3 open-response
# ---------------------------------------------------------------------------

jee_math = [
    {
        "id": "math-001", "subject": "JEE Mathematics", "topic": "Calculus", "type": "mcq", "marks": 4,
        "question_text": "The derivative of sin(x²) with respect to x is:",
        "options": {"A": "cos(x²)", "B": "2x cos(x²)", "C": "2x sin(x²)", "D": "x² cos(x²)"},
        "answer_key": {"correct_answer": "B",
            "distractor_reasoning": {
                "A": "Forgets to apply the chain rule (misses the derivative of the inner function x²).",
                "C": "Confuses the derivative of sine with cosine.",
                "D": "Multiplies by x² instead of the correct chain-rule factor 2x."}},
        "_responses": mcq_responses("B", ["A", "B", "C", "D"]),
    },
    {
        "id": "math-002", "subject": "JEE Mathematics", "topic": "Coordinate Geometry", "type": "mcq", "marks": 4,
        "question_text": "The distance between the points (3, 4) and (7, 1) is:",
        "options": {"A": "5", "B": "7", "C": "25", "D": "√41"},
        "answer_key": {"correct_answer": "A",
            "distractor_reasoning": {
                "C": "Forgets to take the square root of the sum of squares.",
                "D": "Computes 4² + 5² instead of 4² + 3² (mixes up the coordinate differences).",
                "B": "Simply adds the coordinate differences instead of using the distance formula."}},
        "_responses": mcq_responses("A", ["A", "B", "C", "D"]),
    },
    {
        "id": "math-003", "subject": "JEE Mathematics", "topic": "Algebra", "type": "mcq", "marks": 4,
        "question_text": "If the roots of x² - 5x + 6 = 0 are α and β, the value of α² + β² is:",
        "options": {"A": "13", "B": "25", "C": "1", "D": "19"},
        "answer_key": {"correct_answer": "A",
            "distractor_reasoning": {
                "B": "Computes (α+β)² directly without subtracting 2αβ.",
                "C": "Computes (α-β)² instead of α²+β².",
                "D": "Arithmetic slip while expanding (α+β)² - 2αβ."}},
        "_responses": mcq_responses("A", ["A", "B", "C", "D"]),
    },
    {
        "id": "math-004", "subject": "JEE Mathematics", "topic": "Trigonometry", "type": "mcq", "marks": 4,
        "question_text": "The value of sin(30°) + cos(60°) is:",
        "options": {"A": "1", "B": "0.5", "C": "1.5", "D": "√3/2"},
        "answer_key": {"correct_answer": "A",
            "distractor_reasoning": {
                "B": "Adds only one of the two terms (forgets cos(60°) also equals 0.5).",
                "D": "Confuses cos(60°) with cos(30°).",
                "C": "Mistakenly uses sin(60°) instead of sin(30°)."}},
        "_responses": mcq_responses("A", ["A", "B", "C", "D"]),
    },
    {
        "id": "math-005", "subject": "JEE Mathematics", "topic": "Probability", "type": "mcq", "marks": 4,
        "question_text": "Two dice are rolled. The probability of getting a sum of 7 is:",
        "options": {"A": "1/6", "B": "1/12", "C": "6/36", "D": "Both A and C"},
        "answer_key": {"correct_answer": "D",
            "distractor_reasoning": {
                "A": "Correct value but doesn't recognize it's equivalent to 6/36, so wouldn't select the 'both' option.",
                "B": "Miscounts the favorable outcomes for sum=7 as 3 instead of 6.",
                "C": "Correct fraction but doesn't simplify or recognize equivalence to 1/6."}},
        "_responses": mcq_responses("D", ["A", "B", "C", "D"]),
    },
    {
        "id": "math-006", "subject": "JEE Mathematics", "topic": "Vectors", "type": "mcq", "marks": 4,
        "question_text": "If vectors a and b are perpendicular, then a·b equals:",
        "options": {"A": "|a||b|", "B": "0", "C": "1", "D": "|a|+|b|"},
        "answer_key": {"correct_answer": "B",
            "distractor_reasoning": {
                "A": "Confuses the perpendicular condition with the formula for parallel vectors.",
                "C": "Confuses dot product with the cosine of the angle itself.",
                "D": "Confuses dot product rule with vector magnitude addition, unrelated concept."}},
        "_responses": mcq_responses("B", ["A", "B", "C", "D"]),
    },
    {
        "id": "math-007", "subject": "JEE Mathematics", "topic": "Calculus", "type": "true_false", "marks": 2,
        "question_text": "True or False: Every continuous function is differentiable everywhere.",
        "answer_key": {"correct_answer": False,
            "explanation": "False -- e.g. f(x) = |x| is continuous everywhere but not differentiable at x=0."},
        "_responses": true_false_responses(False),
    },
    {
        "id": "math-008", "subject": "JEE Mathematics", "topic": "Algebra", "type": "true_false", "marks": 2,
        "question_text": "True or False: A quadratic equation with real coefficients can have exactly one real root.",
        "answer_key": {"correct_answer": True,
            "explanation": "True -- when the discriminant is zero, the equation has one repeated real root."},
        "_responses": true_false_responses(True),
    },
    {
        "id": "math-009", "subject": "JEE Mathematics", "topic": "Matrices", "type": "true_false", "marks": 2,
        "question_text": "True or False: Matrix multiplication is commutative in general, i.e. AB = BA for all matrices A and B.",
        "answer_key": {"correct_answer": False,
            "explanation": "False -- matrix multiplication is generally non-commutative; AB ≠ BA in most cases."},
        "_responses": true_false_responses(False),
    },
    {
        "id": "math-010", "subject": "JEE Mathematics", "topic": "Sequences and Series", "type": "true_false", "marks": 2,
        "question_text": "True or False: The sum of an infinite geometric series always converges regardless of the common ratio.",
        "answer_key": {"correct_answer": False,
            "explanation": "False -- it converges only when the absolute value of the common ratio is less than 1."},
        "_responses": true_false_responses(False),
    },
    {
        "id": "math-011", "subject": "JEE Mathematics", "topic": "Calculus", "type": "numeric", "marks": 4,
        "question_text": "Evaluate the definite integral of 2x from x=0 to x=3.",
        "answer_key": {"correct_answer": "9", "unit": "", "tolerance_note": "accept 9 or 9.0"},
        "_responses": numeric_responses("9", "", "6"),
    },
    {
        "id": "math-012", "subject": "JEE Mathematics", "topic": "Coordinate Geometry", "type": "numeric", "marks": 4,
        "question_text": "Find the slope of the line passing through points (2, 3) and (6, 11).",
        "answer_key": {"correct_answer": "2", "unit": "", "tolerance_note": "accept 2 or 2.0"},
        "_responses": numeric_responses("2", "", "0.5"),
    },
    {
        "id": "math-013", "subject": "JEE Mathematics", "topic": "Algebra", "type": "numeric", "marks": 4,
        "question_text": "If log(2) = 0.301, find the value of log(8), correct to 3 decimal places.",
        "answer_key": {"correct_answer": "0.903", "unit": "", "tolerance_note": "accept 0.903 ± 0.002"},
        "_responses": numeric_responses("0.903", "", "0.602"),
    },
    {
        "id": "math-014", "subject": "JEE Mathematics", "topic": "Probability", "type": "numeric", "marks": 4,
        "question_text": "A bag contains 5 red and 3 blue balls. Find the probability of drawing a red ball, correct to 3 decimal places.",
        "answer_key": {"correct_answer": "0.625", "unit": "", "tolerance_note": "accept 0.625 or 5/8"},
        "_responses": numeric_responses("0.625", "", "0.375"),
    },
    {
        "id": "math-015", "subject": "JEE Mathematics", "topic": "Trigonometry", "type": "fill_in", "marks": 2,
        "question_text": "The value of tan(45°) is ____.",
        "answer_key": {"correct_answer": "1", "accepted_variants": ["1.0"]},
        "_responses": fill_in_responses("1", "0"),
    },
    {
        "id": "math-016", "subject": "JEE Mathematics", "topic": "Sets", "type": "fill_in", "marks": 2,
        "question_text": "A set that contains no elements is called the ____ set.",
        "answer_key": {"correct_answer": "empty", "accepted_variants": ["null", "void"]},
        "_responses": fill_in_responses("empty", "universal"),
    },
    {
        "id": "math-017", "subject": "JEE Mathematics", "topic": "Complex Numbers", "type": "fill_in", "marks": 2,
        "question_text": "The value of i² (where i is the imaginary unit) is ____.",
        "answer_key": {"correct_answer": "-1", "accepted_variants": ["negative 1", "-1.0"]},
        "_responses": fill_in_responses("-1", "1"),
    },
    {
        "id": "math-018", "subject": "JEE Mathematics", "topic": "Calculus", "type": "open_response", "marks": 3,
        "question_text": "Explain the geometric meaning of the derivative of a function at a point.",
        "answer_key": {"rubric_points": [
            "States the derivative gives the slope of the tangent line to the curve at that point",
            "Explains it as the limit of the slope of secant lines as the second point approaches the first",
            "Connects this to instantaneous rate of change of the function"]},
    },
    {
        "id": "math-019", "subject": "JEE Mathematics", "topic": "Algebra", "type": "open_response", "marks": 3,
        "question_text": "Explain why the discriminant of a quadratic equation determines the nature of its roots.",
        "answer_key": {"rubric_points": [
            "States the discriminant is b² - 4ac",
            "Explains D>0 gives two distinct real roots, D=0 gives one repeated real root, D<0 gives complex roots",
            "Connects this to the square root term in the quadratic formula being real, zero, or imaginary"]},
    },
    {
        "id": "math-020", "subject": "JEE Mathematics", "topic": "Probability", "type": "open_response", "marks": 3,
        "question_text": "Explain the difference between independent events and mutually exclusive events in probability.",
        "answer_key": {"rubric_points": [
            "Independent events: occurrence of one does not affect the probability of the other, P(A∩B)=P(A)P(B)",
            "Mutually exclusive events: cannot occur at the same time, P(A∩B)=0",
            "Notes that two events with nonzero probability can't be both independent and mutually exclusive"]},
    },
]

print(f"jee_math: {len(jee_math)} questions")

# ---------------------------------------------------------------------------
# CBSE Class 10 Science -- 20 questions: 6 MCQ, 4 True/False, 4 numeric, 3 fill-in, 3 open-response
# ---------------------------------------------------------------------------

cbse_science = [
    {
        "id": "sci-001", "subject": "CBSE Class 10 Science", "topic": "Chemical Reactions", "type": "mcq", "marks": 1,
        "question_text": "Which of the following is a physical change?",
        "options": {"A": "Rusting of iron", "B": "Burning of paper", "C": "Melting of wax", "D": "Digestion of food"},
        "answer_key": {"correct_answer": "C",
            "distractor_reasoning": {
                "A": "Rusting is a chemical change (forms iron oxide, new substance) -- commonly mistaken as physical.",
                "B": "Burning is a chemical change (combustion produces new substances).",
                "D": "Digestion involves chemical breakdown of food into new substances."}},
        "_responses": mcq_responses("C", ["A", "B", "C", "D"]),
    },
    {
        "id": "sci-002", "subject": "CBSE Class 10 Science", "topic": "Life Processes", "type": "mcq", "marks": 1,
        "question_text": "The functional unit of the kidney is called the:",
        "options": {"A": "Neuron", "B": "Nephron", "C": "Alveolus", "D": "Villus"},
        "answer_key": {"correct_answer": "B",
            "distractor_reasoning": {
                "A": "Confuses the kidney's functional unit with the nervous system's functional unit.",
                "C": "Confuses with the functional unit of the lungs.",
                "D": "Confuses with the structure in the small intestine responsible for absorption."}},
        "_responses": mcq_responses("B", ["A", "B", "C", "D"]),
    },
    {
        "id": "sci-003", "subject": "CBSE Class 10 Science", "topic": "Electricity", "type": "mcq", "marks": 1,
        "question_text": "The SI unit of electrical resistance is the:",
        "options": {"A": "Ampere", "B": "Volt", "C": "Ohm", "D": "Watt"},
        "answer_key": {"correct_answer": "C",
            "distractor_reasoning": {
                "A": "This is the unit of current, not resistance.",
                "B": "This is the unit of potential difference, not resistance.",
                "D": "This is the unit of power, not resistance."}},
        "_responses": mcq_responses("C", ["A", "B", "C", "D"]),
    },
    {
        "id": "sci-004", "subject": "CBSE Class 10 Science", "topic": "Light", "type": "mcq", "marks": 1,
        "question_text": "A concave mirror always forms a virtual image when the object is placed:",
        "options": {"A": "Beyond the centre of curvature", "B": "At the focus", "C": "Between the pole and the focus", "D": "At the centre of curvature"},
        "answer_key": {"correct_answer": "C",
            "distractor_reasoning": {
                "A": "Object beyond C gives a real, diminished image, not virtual.",
                "B": "At focus, the image forms at infinity (real, highly enlarged), not virtual.",
                "D": "At C, the image forms at C itself, real and same size, not virtual."}},
        "_responses": mcq_responses("C", ["A", "B", "C", "D"]),
    },
    {
        "id": "sci-005", "subject": "CBSE Class 10 Science", "topic": "Natural Resources", "type": "mcq", "marks": 1,
        "question_text": "The ozone layer protects the Earth from which type of radiation?",
        "options": {"A": "Infrared", "B": "Ultraviolet", "C": "Microwave", "D": "Radio waves"},
        "answer_key": {"correct_answer": "B",
            "distractor_reasoning": {
                "A": "Confuses UV with infrared, both often grouped loosely as 'invisible radiation' by students.",
                "C": "Not typically associated with atmospheric filtering at this level.",
                "D": "Not typically associated with atmospheric filtering at this level."}},
        "_responses": mcq_responses("B", ["A", "B", "C", "D"]),
    },
    {
        "id": "sci-006", "subject": "CBSE Class 10 Science", "topic": "Acids Bases and Salts", "type": "mcq", "marks": 1,
        "question_text": "The pH of a neutral solution at room temperature is:",
        "options": {"A": "0", "B": "7", "C": "14", "D": "1"},
        "answer_key": {"correct_answer": "B",
            "distractor_reasoning": {
                "A": "Confuses neutral pH with the most acidic end of the scale.",
                "C": "Confuses neutral pH with the most basic end of the scale.",
                "D": "Assumes a strongly acidic value is 'neutral', a common early misconception."}},
        "_responses": mcq_responses("B", ["A", "B", "C", "D"]),
    },
    {
        "id": "sci-007", "subject": "CBSE Class 10 Science", "topic": "Chemical Reactions", "type": "true_false", "marks": 1,
        "question_text": "True or False: A balanced chemical equation must have an equal number of atoms of each element on both sides.",
        "answer_key": {"correct_answer": True,
            "explanation": "True -- this reflects the law of conservation of mass."},
        "_responses": true_false_responses(True),
    },
    {
        "id": "sci-008", "subject": "CBSE Class 10 Science", "topic": "Life Processes", "type": "true_false", "marks": 1,
        "question_text": "True or False: Respiration in plants occurs only during the day.",
        "answer_key": {"correct_answer": False,
            "explanation": "False -- respiration occurs continuously (day and night); only photosynthesis is light-dependent."},
        "_responses": true_false_responses(False),
    },
    {
        "id": "sci-009", "subject": "CBSE Class 10 Science", "topic": "Electricity", "type": "true_false", "marks": 1,
        "question_text": "True or False: Connecting resistors in parallel always increases the total resistance of the circuit.",
        "answer_key": {"correct_answer": False,
            "explanation": "False -- parallel combination always decreases the total (equivalent) resistance."},
        "_responses": true_false_responses(False),
    },
    {
        "id": "sci-010", "subject": "CBSE Class 10 Science", "topic": "Heredity", "type": "true_false", "marks": 1,
        "question_text": "True or False: Traits acquired by an organism during its lifetime can be passed on to its offspring.",
        "answer_key": {"correct_answer": False,
            "explanation": "False -- acquired characteristics are not heritable; only genetic (germline) changes are passed on."},
        "_responses": true_false_responses(False),
    },
    {
        "id": "sci-011", "subject": "CBSE Class 10 Science", "topic": "Electricity", "type": "numeric", "marks": 3,
        "question_text": "A resistor of 5 Ω carries a current of 2 A. Find the potential difference across it, in volts.",
        "answer_key": {"correct_answer": "10", "unit": "V", "tolerance_note": "accept 10 or 10.0"},
        "_responses": numeric_responses("10", "V", "2.5"),
    },
    {
        "id": "sci-012", "subject": "CBSE Class 10 Science", "topic": "Electricity", "type": "numeric", "marks": 3,
        "question_text": "Calculate the power dissipated in a device that draws 3 A of current at 20 V, in watts.",
        "answer_key": {"correct_answer": "60", "unit": "W", "tolerance_note": "accept 60 or 60.0"},
        "_responses": numeric_responses("60", "W", "6.67"),
    },
    {
        "id": "sci-013", "subject": "CBSE Class 10 Science", "topic": "Light", "type": "numeric", "marks": 3,
        "question_text": "An object is placed 20 cm in front of a concave mirror of focal length 10 cm. Find the image distance, in cm.",
        "answer_key": {"correct_answer": "20", "unit": "cm", "tolerance_note": "accept 20 or 20.0"},
        "_responses": numeric_responses("20", "cm", "10"),
    },
    {
        "id": "sci-014", "subject": "CBSE Class 10 Science", "topic": "Acids Bases and Salts", "type": "numeric", "marks": 3,
        "question_text": "How many grams of NaOH (molar mass 40 g/mol) are needed to make 0.5 mol of solution?",
        "answer_key": {"correct_answer": "20", "unit": "g", "tolerance_note": "accept 20 or 20.0"},
        "_responses": numeric_responses("20", "g", "80"),
    },
    {
        "id": "sci-015", "subject": "CBSE Class 10 Science", "topic": "Life Processes", "type": "fill_in", "marks": 1,
        "question_text": "The green pigment in plants that absorbs light for photosynthesis is called ____.",
        "answer_key": {"correct_answer": "chlorophyll", "accepted_variants": ["Chlorophyll"]},
        "_responses": fill_in_responses("chlorophyll", "chloroplast"),
    },
    {
        "id": "sci-016", "subject": "CBSE Class 10 Science", "topic": "Natural Resources", "type": "fill_in", "marks": 1,
        "question_text": "The process by which water changes from a liquid to a gas is called ____.",
        "answer_key": {"correct_answer": "evaporation", "accepted_variants": ["Evaporation"]},
        "_responses": fill_in_responses("evaporation", "condensation"),
    },
    {
        "id": "sci-017", "subject": "CBSE Class 10 Science", "topic": "Heredity", "type": "fill_in", "marks": 1,
        "question_text": "The basic unit of heredity that is passed from parents to offspring is called a ____.",
        "answer_key": {"correct_answer": "gene", "accepted_variants": ["Gene"]},
        "_responses": fill_in_responses("gene", "chromosome"),
    },
    {
        "id": "sci-018", "subject": "CBSE Class 10 Science", "topic": "Life Processes", "type": "open_response", "marks": 3,
        "question_text": "Explain why the small intestine in humans is long and has a highly folded inner surface.",
        "answer_key": {"rubric_points": [
            "States the small intestine is the main site of digestion and absorption of nutrients",
            "Explains the folded surface (villi/microvilli) increases surface area",
            "Connects greater surface area to more efficient absorption of digested food into the blood"]},
    },
    {
        "id": "sci-019", "subject": "CBSE Class 10 Science", "topic": "Chemical Reactions", "type": "open_response", "marks": 3,
        "question_text": "Explain why displacement reactions occur between metals, using the example of iron reacting with copper sulphate solution.",
        "answer_key": {"rubric_points": [
            "States a more reactive metal displaces a less reactive metal from its salt solution",
            "Identifies iron is more reactive than copper (based on reactivity series)",
            "Describes iron displacing copper: Fe + CuSO4 -> FeSO4 + Cu, with the blue solution fading and a reddish-brown deposit forming"]},
    },
    {
        "id": "sci-020", "subject": "CBSE Class 10 Science", "topic": "Natural Resources", "type": "open_response", "marks": 3,
        "question_text": "Explain how deforestation contributes to soil erosion.",
        "answer_key": {"rubric_points": [
            "States tree roots bind soil particles together, holding topsoil in place",
            "Explains that without tree cover, rain/wind directly hits and washes away exposed topsoil",
            "Notes the loss of topsoil reduces fertility and can lead to desertification over time"]},
    },
]

print(f"cbse_science: {len(cbse_science)} questions")
print(f"TOTAL: {len(jee_physics) + len(jee_math) + len(cbse_science)} questions")

# ---------------------------------------------------------------------------
# Export
# ---------------------------------------------------------------------------

ALL_SUBJECTS = {
    "jee_physics": jee_physics,
    "jee_mathematics": jee_math,
    "cbse_science": cbse_science,
}

CLOSED_TYPES = {"mcq", "true_false", "numeric", "fill_in"}

DISTRIBUTION_NOTE = (
    "Each closed-type question has 15 simulated student responses in a fixed, "
    "documented distribution: 8 correct (phrasing/format variants), 3 incorrect "
    "via a specific misconception, 2 boundary/format-edge-case, 1 blank, 1 "
    "gibberish/off-topic. gold_label is the ground truth for scoring grader "
    "accuracy -- it is NOT input to the grader under test."
)

for subject_key, questions in ALL_SUBJECTS.items():
    answer_keys = []
    closed_responses = []
    open_response_tasks = []

    for q in questions:
        # answer_key file: strip internal helper fields
        entry = {k: v for k, v in q.items() if not k.startswith("_")}
        answer_keys.append(entry)

        if q["type"] in CLOSED_TYPES:
            rows = build_student_rows(q["id"], q["_responses"])
            closed_responses.extend(rows)
        else:
            # open_response: hand off generation, don't fabricate answer text here
            open_response_tasks.append({
                "question_id": q["id"],
                "subject": q["subject"],
                "question_text": q["question_text"],
                "rubric_points": q["answer_key"]["rubric_points"],
                "students_to_generate": [
                    {"student_id": f"S{i:02d}", "gold_label": label}
                    for i, label in enumerate(
                        ["correct"] * 8 + ["incorrect_misconception"] * 3
                        + ["boundary_or_partial"] * 2 + ["malformed_blank"]
                        + ["malformed_gibberish_or_offtopic"], start=1)
                ],
            })

    with open(f"{OUT_DIR}/{subject_key}_answer_key.json", "w") as f:
        json.dump({"subject": questions[0]["subject"], "questions": answer_keys}, f, indent=2)

    with open(f"{OUT_DIR}/{subject_key}_student_responses_closed.json", "w") as f:
        json.dump({"subject": questions[0]["subject"], "note": DISTRIBUTION_NOTE,
                    "responses": closed_responses}, f, indent=2)

    with open(f"{OUT_DIR}/{subject_key}_open_response_generation_tasks.json", "w") as f:
        json.dump({"subject": questions[0]["subject"], "tasks": open_response_tasks}, f, indent=2)

    print(f"{subject_key}: {len(answer_keys)} questions, {len(closed_responses)} closed-type responses, "
          f"{len(open_response_tasks)} open-response tasks to generate")

print("\nExport complete ->", OUT_DIR)
